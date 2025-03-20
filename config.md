under `$HOME` folder, a file named `.gitconfig` stores global git configs, here's an example:

```git
[user]
	name = john
	email = john1996@gmail.com
[init]
	defaultBranch = main
[core]
	# force git to be case sensitive (useful for macOS)
	ignoreCase = false
[fetch]
	# Auto rm remote-tracking refs that no longer exist on the remote
	prune = true
[push]
	default = current
	autoSetupRemote = true
[alias]
	st = status
	lp = log --pretty='%Cgreen%h %Creset%ae %ar %C(cyan)<%s>'
	fo = fetch origin

	# commit related
	cm = commit -m
	ca = commit --amend

	# stash related
	sl = stash list
	sa = stash apply
	sp = stash pop
	sm = stash -m

	# list branch sort by commit date(newest comes first)
	# list out last commit date/commit id/branch name(highlight current branch)/relative commit date
	br = for-each-ref --sort=-committerdate refs/heads/ --format=\"%(committerdate:short) %(color:red)%(objectname:short) %(if)%(HEAD)%(then)%(color:cyan)* %(else)%(color:yellow)%(end)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset))\"

	# list out all aliases ( `!` runs normal shell commands)
	alias = ! git config -l | grep -E "^alias"
```

under current folder, a folder name `.git` stores all things related to git. inside it a file named `config` stores local git config

if the same item exist both in local & global git config, local config will take effect (overwriting global config)

- `git config --global --list`

- `git config --local --list`

- `git config --local user.name 'john'`

- `git config --local user.email 'john2000@gmail.com'`

- `git config --local http.proxy http://proxyUsername:proxyPassword@proxy.server.com:port`
