under `$HOME` folder, a file named `.gitconfig` stores global git configs, here's an example:

```git
[user]
	name = john
	email = john1996@gmail.com
[init]
	defaultBranch = main
[core]
	# force git to be case sensitive (which it by default is not under macOS)
	ignoreCase = false
[push]
	default = current
	autoSetupRemote = true
[alias]
	fo = fetch origin
	cm = commit -m
	ca = commit --amend
	lp = log --pretty='%Cgreen%h %Creset%ae %ar %C(cyan)<%s>'
```

under current folder, a folder name `.git` stores all things related to git. inside it a file named `config` stores local git config

if the same item exist both in local & global git config, local config will take effect (overwriting global config)

- `git config --global --list`

- `git config --local --list`

- `git config --local user.name 'john'`

- `git config --local user.email 'john2000@gmail.com'`

- `git config --local http.proxy http://proxyUsername:proxyPassword@proxy.server.com:port`
