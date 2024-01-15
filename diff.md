## diff between working tree and commit

- `git diff`: by default, git diff without any parameter shows diff between working tree & HEAD (`git diff HEAD`)
- `git diff {commit_id}` diff working tree & a specific commit
- `git diff --cache` show diff between staging area & HEAD

## diff between commits

`git diff {commit_a} {commit_b}`

Note: the order of commit id matters, `git diff {commit_a} {commit_b}` & `git diff {commit_b} {commit_a}` are different.

## options

- `--cached` show diff between staging area & HEAD
- `--shortstat` shows only number of changed files as well as added & deleted lines

## Jargons & Conventions

#### Tilde postfix

The `~` postfix means ancestor, by default it's parent commit. 

e.g. `b77bfd22~` means parent commit of `b77bfd22`, it's the same of `b77bfd22~1`. Similarly, `b77bfd22~2` means grandparent commit of `b77bfd22`.

`git diff b77bfd22 b77bfd22~2`: show diff between `b77bfd22` and it's grandparent.

#### Working tree

#### HEAD
