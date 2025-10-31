under `$HOME` folder, a file named `.gitconfig` stores global git configs, here's an example:

```git
[user]
	name = Your Name
	email = xyz@example.com
[init]
	defaultBranch = main
[fetch]
	# Auto rm remote-tracking refs that no longer exist on the remote
	prune = true
[pull]
	rebase = true
[push]
	default = current
	autoSetupRemote = true
[alias]
	# list out all aliases (`!` runs normal shell commands)
	la = ! git config -l | grep -E "^alias"
  # list out all branches
  lb = for-each-ref refs/heads/ --sort=-committerdate \
       --format=\"%(committerdate:short) %(color:red)%(objectname:short) %(if)%(HEAD)%(then)%(color:cyan)* %(else)%(color:yellow)%(end)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset))\"
  # list out commits (pretty log)
	lc = log --pretty='%Cgreen%h %Creset%an %ar %C(cyan)<%s>' # pretty log. see: https://git-scm.com/docs/pretty-formats

  # common
	st = status
  	sw = switch
	br = branch
  	ds = diff --stat
  	wt = worktree
  	dac = ! git clean -df && git restore . # discard all changes (not including staged changes)
	pr = pull --rebase # if local & remote branch diverged, rebase instead of generating a merge commit
	pf = push --force-with-lease # safer altenative to --force

	# commit related
	cm = commit -m
	ca = commit --amend

	# stash related
	sl = stash list
	sa = stash apply
	sp = stash pop
	sm = stash -m
```

under current folder, a folder name `.git` stores all things related to git. inside it a file named `config` stores local git config

if the same item exist both in local & global git config, local config will take effect (overwriting global config)

- `git config --global --list`

- `git config --local --list`

- `git config --local user.name 'john'`

- `git config --local user.email 'john2000@gmail.com'`

- `git config --local http.proxy http://proxyUsername:proxyPassword@proxy.server.com:port`
