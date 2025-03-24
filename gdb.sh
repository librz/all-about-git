# gdb: git delete branch (by regex)
function gdb () {
  # basic check
  if ! git status &> /dev/null
  then
    echo "You are not inside a git repo"
    return 1
  fi

  # get repo type (local or remote)
  echo "1. Local branch(es)"
  echo "2. Remote branch(es)"
  echo -n "Which type of branch(es) to delete(1 or 2): "
  read -r repo_type
  if [[ "$repo_type" -ne 1 && "$repo_type" -ne 2 ]]; then
    echo "Only 1 or 2 are permitted"
    return 1
  fi

  if [[ "$repo_type" -eq 2 ]]; then
    # get remote name
    echo
    git remote
    echo
    echo -n "Which remote is your target: "
    read -r remote
    if ! git remote | grep -q "$remote"
    then
      echo "No such remote"
      return 1
    fi
  fi

  # list out all branches
  echo
  if [[ "$repo_type" -eq 1 ]]; then
    all_branches_count=$(git branch | grep -c '^')
    echo "Found $all_branches_count local branches"
    echo
    git branch
  else
    # fetching branches for that remote
    echo "Fetching branches on $remote"
    echo
    git fetch --prune
    all_branches=$(git branch -a | grep -i "remotes/${remote}")
    all_branch_count=$(echo -n "$all_branches" | grep -c '^')
    echo "Found $all_branch_count branches on ${remote}"
    echo
    echo "$all_branches"
  fi

  # ask for branch regex
  echo
  echo -n "Branch regex (no need to surround it with //): "
  read -r branch_regex

  # get branches to delete
  if [[ "$repo_type" -eq 1 ]]; then
    branches=$(git branch | awk -v pattern="$branch_regex" '$1 ~ pattern {print $1}')
  else
    branches=$(git branch -a | grep -i "remotes/${remote}" | awk -v pattern="$branch_regex" -F'/' '$3 ~ pattern {print $3}')
  fi
  branch_count=$(echo -n "$branches" | grep -c '^')
  if [[ "$branch_count" -eq 0 ]]
  then
    echo "No branch matched"
    return 1
  fi
  echo
  echo "$branch_count branches matched: "
  echo
  echo "$branches"
  echo

  # ask for confirmation
  echo -n "Delete all branches listed above? (Y/N): "
  read -r confirm
  echo
  if ! [[ "$confirm" =~ ^[Yy][Es]?[Ss]? ]]
  then
    echo "Aborted"
    return
  fi

  # delete branch one by one
  while IFS= read -r branch
  do
    if [[ "$repo_type" -eq 1 ]]; then
      git branch -D "$branch"
    else
      git push "$remote" --delete "$branch"
    fi
  done <<< "$branches"

  echo
  echo "DONE"
}
