`git rebase` gives u the ability to *rewrite* commit history.

### edit commit history

U can use `git rebase -i {commit_hash}` to edit commits, by doing this, u can:

1. change commit message
2. squash multiple commits into one
3. reorder commits (not recommended)
4. delete commits (not recommeded, u should use revert)


### reapply commits from another branch

Suppose both `feat-a` & `hotfix-b` are based on `main` branch:

On `feat-a`, u made 2 commits, commit hash is `c7a1522` & `e4ec41f`

On `hotfix-b`, Bob made 1 commits as well, commit hash is `5544060`

Both `feat-a` & `hotfix-b` is supposed to be released tomorrow, Bob's change is small so he asks whether u can accept his changes on `feat-a` so that only `feat-a` is needed for releasing.

There are 3 ways:

1. on `feat-a` branch: `git merge hotfix-b` 
2. on `feat-a` branch, `git cherry-pick 5544060`
3. on `feat-a` branch, `git rebase hotfix-b`

Although all 3 ways are viable, merge & cherry-pick have the following quirks:

1. merge will generate a new merge commit
2. cherry-pick will modify original commit hash

Using `rebase` there won't be a new merge commit & orignal commit hash is kept. After `rebase`, commit history will be:

```markdown
e4ec41f
c7a1522
5544060 // commit from hotfix-b
```

This way, commit history is very clean.

### caution

Normally, commits history is *generated* as you commit. `rebase` let's u *edit* it. This is kind of like black magic.

U **should not** rebase commits that u have pushed to public repo, that way u'll have to force push which causes confusion for other people.
