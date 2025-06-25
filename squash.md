Squash 2 or more commits as 1 commit.

This operation falls into the `change-history` category, so naturally u can do this with `rebase`.

Specifically interactive rebase: `git rebase -i {commit_id}`. (here the commit id literally means commit identifier, could be commit has or conventions such as `HEAD~3`)

This will fire up your default editor and let you edit the rebase file. Do the following:

1. The first commit should remain `pick`
2. For subsequent commits you want to squash into first one, change `pick` to `squash` (or `s`).
3. Save & close
