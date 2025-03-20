under `$HOME` folder, a file named `.gitconfig` stores global git configs, here's an example:

```git
[user]
	name = Patrick Ren
	email = 193862497+lib-patrick@users.noreply.github.com
[init]
	defaultBranch = main
[fetch]
	# Auto rm remote-tracking refs that no longer exist on the remote
	prune = true
[push]
	default = current
	autoSetupRemote = true
[alias]
	# list out all aliases (`!` runs normal shell commands)
	la = ! git config -l | grep -E "^alias"

	# common
	st = status
  	sw = switch
	pl = log --pretty='%Cgreen%h %Creset%ae %ar %C(cyan)<%s>' # pretty log. see: https://git-scm.com/docs/pretty-formats
	dac = ! git clean -df && git restore . # discard all changes (discard untracked files & dirs, changes in working dir)
	pick = cherry-pick  # pick commit(s)

	# commit related
	cm = commit -m
	ca = commit --amend

	# stash related
	sl = stash list
	sa = stash apply
	sp = stash pop
	sm = stash -m

	# restore related
	r = restore # discard changes in working directory
	rs = restore --staged  # unstage file(s)

	# diff related
	d = diff # diff with changes working directory
	ds = diff --staged # diff with staged changes 
	dst = diff --stat

	# branch related
	br = for-each-ref refs/heads/ --sort=-committerdate \
       --format=\"%(committerdate:short) %(color:red)%(objectname:short) %(if)%(HEAD)%(then)%(color:cyan)* %(else)%(color:yellow)%(end)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset))\"
```

under current folder, a folder name `.git` stores all things related to git. inside it a file named `config` stores local git config

if the same item exist both in local & global git config, local config will take effect (overwriting global config)

- `git config --global --list`

- `git config --local --list`

- `git config --local user.name 'john'`

- `git config --local user.email 'john2000@gmail.com'`

- `git config --local http.proxy http://proxyUsername:proxyPassword@proxy.server.com:port`
