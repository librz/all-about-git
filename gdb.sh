# git delete branch (by regex and/or date)
function gdb () {
	if ! git status &> /dev/null
	then
		echo "You are not inside a git repo"
		return 1
	fi

	protected_regex="^(main|master|dev|development|staging)$"

	echo "1. Local branch(es)"
	echo "2. Remote branch(es)"
	echo -n "Which type of branch(es) to delete (1 or 2): "
	read -r repo_type
	if [[ "$repo_type" -ne 1 && "$repo_type" -ne 2 ]]
	then
		echo "Only 1 or 2 are permitted"
		return 1
	fi

	if [[ "$repo_type" -eq 2 ]]
	then
		echo
		git remote
		echo
		echo -n "Which remote is your target: "
		read -r remote
		if ! git remote | grep -q "^${remote}$"
		then
			echo "No such remote"
			return 1
		fi
	fi
	echo

	if [[ "$repo_type" -eq 1 ]]
	then
		all_branches=$(git for-each-ref --sort=-committerdate --format="%(refname:short)|%(committerdate:relative)" refs/heads/)
	else
		echo "Fetching branches on $remote..."
		git fetch --prune
		all_branches=$(git for-each-ref --sort=-committerdate --format="%(refname:lstrip=3)|%(committerdate:relative)" "refs/remotes/$remote/")
	fi

	echo "Found $(echo -n "$all_branches" | grep -c '^') branches (Newest to Oldest):"
	echo "$all_branches" | awk -F'|' '{printf "  %-40s %s\n", $1, $2}'
	echo

	echo "1. Delete by Regex"
	echo "2. Delete by Date"
	echo "3. Delete by Regex & Date"
	echo -n "Choose deletion method (1, 2, or 3): "
	read -r filter_type
	echo

	if [[ "$filter_type" -lt 1 || "$filter_type" -gt 3 ]]
	then
		echo "Invalid choice. Only 1, 2, or 3 are permitted."
		return 1
	fi

	branch_regex=".*"
	threshold=9999999999

	if [[ "$filter_type" -eq 1 || "$filter_type" -eq 3 ]]
	then
		echo -n "Branch regex (leave blank for all): "
		read -r temp_regex
		[[ -n "$temp_regex" ]] && branch_regex="$temp_regex"
	fi

	if [[ "$filter_type" -eq 2 || "$filter_type" -eq 3 ]]
	then
		echo -n "Older than (e.g. '2h', '3d', '4w', '2m', '1y'): "
		read -r time_input

		val=$(echo "$time_input" | tr -dc '0-9')
		unit=$(echo "$time_input" | tr -dc 'a-zA-Z' | tr '[:upper:]' '[:lower:]')

		if [[ -z "$val" ]]; then
			echo "Invalid format. Expected a number (e.g., '2h', '3d')."
			return 1
		fi

		[[ -z "$unit" ]] && unit="d"

		# --- BUG FIX: Capped Buffer ---
		# We define both the multiplier and a static buffer.
		# Weeks, months, and years strictly use a 1-day buffer (86400) instead of expanding infinitely.
		case "$unit" in
			"h") multiplier=3600; buffer=3600 ;;
			"d") multiplier=86400; buffer=86400 ;;
			"w") multiplier=604800; buffer=86400 ;;
			"m") multiplier=2592000; buffer=86400 ;;
			"y") multiplier=31536000; buffer=86400 ;;
			*)
				echo "Invalid unit: '$unit'. Use h, d, w, m, or y."
				return 1
				;;
		esac

		now=$(date +%s)
		threshold=$(( now - (val * multiplier) - buffer ))
	fi

	if [[ "$repo_type" -eq 1 ]]; then
		ref_path="refs/heads/"
		lstrip=2
	else
		ref_path="refs/remotes/$remote/"
		lstrip=3
	fi

	branches_raw=$(git for-each-ref --sort=-committerdate --format="%(refname:lstrip=$lstrip)|%(committerdate:unix)|%(committerdate:relative)" "$ref_path" | \
		awk -F'|' -v pattern="$branch_regex" -v thresh="$threshold" -v type="$filter_type" -v protect="$protected_regex" \
		'$1 != "HEAD" && $1 !~ protect {
			if (type == 1 && $1 ~ pattern) print $0;
			else if (type == 2 && ($2 + 0) < (thresh + 0)) print $0;
			else if (type == 3 && $1 ~ pattern && ($2 + 0) < (thresh + 0)) print $0
		}')

	branch_count=$(echo -n "$branches_raw" | grep -c '^')
	if [[ -z "$branches_raw" || "$branch_count" -eq 0 ]]
	then
		echo "No unprotected branch matched the criteria."
		return 1
	fi

	echo
	echo "$branch_count unprotected branches matched (Newest to Oldest):"
	echo "$branches_raw" | awk -F'|' '{printf "  %-40s %s\n", $1, $3}'
	echo
	echo -n "Delete all branches listed above? (Y/N): "
	read -r confirm
	if [[ ! "$confirm" =~ ^[Yy][Es]?[Ss]? ]]; then echo "Aborted"; return; fi

	while IFS='|' read -r branch utime reldate
	do
		[[ -z "$branch" ]] && continue
		if [[ "$repo_type" -eq 1 ]]; then git branch -D "$branch"
		else git push "$remote" --delete "$branch"; fi
	done <<< "$branches_raw"

	echo
	echo "DONE"
}

		}
	'
}
