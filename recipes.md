### init

- `git init {folder}` (folder is optional, by default it's the current directory)

- `git clone {url}` (url protocol could be ssh/git/http[s]/ftp[s]. e.g.: `git@github.com:librz/shell-scripts.git`)

### basic inspection

- `git --version`

- `git status` (status of current branch & it's relation with its remote tracking branch)

- `git remote -v` (v for verbose mode,)

- `git branch -av` (without the -a flag, git will only show local branches; with the -v flag, commit id & message of each head will be printed)

- `git log --oneline -n10 --decorate --graph`

- `git show-ref --heads` print all

### stage & commit

- stage(track) files/folders: `git add file1.js folder1`

- stage all changes(tracked & untracked files): `git add .` or `git add -A` (`git add .` stages all changes under current directory and sub-directories, `git add -A` or `git add --all` stages all changes throughout the entire repo)

- stage updates to tracked files: `git add -u`

- mv or rename file/folder: `git mv add.js Add.js`

- commit changes in staging area: `git commit -m 'update readme'`

- commit changes without running pre-commit hooks: `git commit --no-verify -m "commit message"`

- commit with not only a message but also detailed description: [stackoverflow question](https://stackoverflow.com/questions/16122234/how-to-commit-a-change-with-both-message-and-description-from-the-command-li)

- unstage all changes (moving changes from staging area to working tree): `git reset HEAD` or `git restore --staged .` (note git restore is only available after v2.23)

- discard all changes in working tree: `git checkout -- .` or `git restore .` (note git restore is only available after v2.23)

### sync (local <=> remote)

- `git fetch {remote}` fetch status of all branches from remote

- `git fetch {remote} {branch}` fetch status of specified branch from remote

- `git fetch --prune {{remote name}}` Without `--prune `, remote-tracking branches will stay forever on local cache even some of them may have been removed on remote

- `git push` push to remote branch (suppose you already specified a remote branch before)

- `git push -u {remote} {branch}` set upstream branch & push to it

- `git push -f {remote} {branch}` force push to remote branch, this is DANGEROUS (never force push to a shared branch)

- `git pull` pull changes from remote branch

sometimes, when you do `git status` or `git pull`, git tells you `your local branch has diverged with remote`, usually it means the `HEAD` of your local barnch & remote branch is different (having different commit IDs). If you want to forfeit your local `HEAD`, you could just do `git reset --hard {remote}/{branch}`. [More details](https://stackoverflow.com/questions/2452226/master-branch-and-origin-master-have-diverged-how-to-undiverge-branches)

### branch management

- switch branch `git checkout {branch}` or `git switch {branch}` (note: git switch is a relatively new command, available in git v2.32(release in 2019-08-16) or above)

- switch to a new branch based on current branch: `git checkout -b {branch}` or `git switch -c {branch}`(`-c` is short for `--create`)

- create a backup branch based on current branch: `git branch {branch}`

- switch to a new branch based on certain commit: `git checkout -b {branch} {commit_id}`

- delete local branch: `git branch -d|--delete {branch}` or `git branch -D {branch}` to forcefully delete

- delete remote branch: `git push {remote} --delete {branch}`

- rename current branch: `git branch -m {new name}`

- start a new branch based on head of remote branch: `git checkout -b {branch} {remote}/{branch}`

- start a new branch based on head of remote branch but do not track the remote branch `git checkout -b {branch} --no-track {remote}/{branch}` (this can be useful when you want to checkout a branch from the official branch but do not want or simply don't have the access to push directly to it, instead you want to push to a forked repo and then raise a PR to merge into the official repo's branch. Often times, you need to run `git fetch {remote}` first to get the latest status of remote branches)

### remote management

- inspect: `git remote -v`
- add: `git remote add {remote_name} {url}`
- remove: `git remote remove {remote_name}`
- change url: `git remote set-url {remote_name} {url}`

### merge

When merging, there are 3 scenarios:

1. Fast forword. e.g. Branch B are based on branch A, there were some new commits made on branch B, A stays unchanged, when merge B into A, A will just fast forward to latest commit on B.
2. Branch diverged but no conflicts. In this case, a new merged will be generated, this commit will have 2 parent commits(the latest commit on both branches).
3. Branch diverged & has conflicts. In this case, you'll have to manually resolve merge conflicts, after resolved, you need to manually make a new commit.

- merge another branch into current branch: `git merge {branch}`

- merge remote branch into current local branch: `git merge {remote}/{branch}`

### cherry pick

Cherry pick allows u to pick only certain commit(s) and apply changes introduced by them. For each picked commit, a new commit(same diff, same commit message but new commit id) will be generated.

- cherry pick single commit: `git cherry-pick {commit id}`
- cherry pick multiple commits: `git cherry-pick {commit_id_1} {commit_id_2} {commit_id_3}`
- cherry pick multiple **successive** commits: `git cherry-pick {start_commit_id}^..{end_commit_id}` (by default start commit is not included, append `^` to include it)

### history navigation

- `git checkout {commit_id}`

### rewrite history

- change commit message of last commit: `git commit --amend -m "new message"` (note: this will delete the old commit & generate a new commit with a new commit id and message)
- include more changes to last commit without updating commit message: `git commit --amend --no-edit`
- change any message in history: `git rebase -i {{ any parent commit id before the commit you want to change }}` then change the action for the targeted commit from `pick` to `reword`
- squash multiple commits into one: `git rebase -i {{ any parent commit id before the commits you want to squash }}` then change the action for commits you want to squash from `pick` to `squash` (note you should pick the oldest commit among the commits you want to squash to serve as the destination for squash) (note you can reorder commits when rebasing but it can cause conflict, only do it when you are very confident of what you are doing)
- delete commits until a certain commit(dangerous): `git reset --hard {{commit id}}`, you can also do `git reset --hard HEAD~{{count}}` (`count` is the number of commits you'd like to delete)
- delete commits but keep the changes in working directory: `git reset --soft {{commit id}}` or `git reset --soft HEAD~{{count}}` (I think you can emit the `--soft` as it's default behavior)
- push to remote branch after history is rewritten: `git push -f` (note: -f is dangerous especially when there are other team members who work on the same branch, only do this if the commit you are rewriting is already pushed to remote branch & no other team member is working on that remote branch)

### tagging

- list all tags: `git tag`
- delete tag: `git tag -d {tag_name}`
- create a simple tag: `git tag {tag_name}`
- create an annotated tag: `git tag -a {tag_name} -m {message}`
- push tag to remote: `git push {remote_name} {tag_name}`

### miscellaneous

- list out contributors, order by commits count: `git shortlog -s -n`
- list all files tracked by git: `git ls-tree --full-tree --name-only -r {commit}`
- tell git to stop traking file: `git rm --cached {file}`
- tell git to stop tracking folder & files under it: `git rm -r --cached {folder}`
