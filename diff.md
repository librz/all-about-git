#### basic usage

- `git diff`: by default, git diff without any parameter shows *unstaged* changes
- `git diff --staged`: show *staged* changes, u can also do `git diff --cached`
- `git diff HEAD`: show *all uncommitted* changes(whether it's staged or not)
- `git diff {commit_id}` diff working tree & a specific commit

#### diff between commits

`git diff {commit_a} {commit_b}`

Note: the order of commit id matters, the above command basically says: compared to `commit_a` what's changed by `commit_b`

Normally, you'd want to do diff according to commit timeline: `git diff {older_commit_id} {newer_commit_id}`

#### advanced options

- `--shortstat`:  shows only number of changed files as well as added & deleted lines
- exlude certain file(s): `git diff HEAD~1 HEAD ':(exclude)package-lock.json'`. For details, refer to [stackoverflow](https://stackoverflow.com/questions/10415100/exclude-file-from-git-diff)

#### about tilder(~) syntax

The `~` postfix means ancestor, by default it's parent commit. 

e.g. 

`b77bfd22~` means parent commit of `b77bfd22`, it's the same of `b77bfd22~1`. Similarly, `b77bfd22~2` means grandparent commit of `b77bfd22`.

`git diff b77bfd22 b77bfd22~2`: show diff between `b77bfd22` and it's grandparent.
