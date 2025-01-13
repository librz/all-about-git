### .gitignore

]The `.gitignore` file dictates what files should be ignored by git.

It uses the linux glob pattern for pattern matching.

Here's some notes:

<img width="680" alt="Screenshot 2024-09-16 at 23 06 12" src="https://github.com/user-attachments/assets/d9d17029-924d-479c-a29e-af42b2cfed88">

### ignore file with git config

First, you need to config git: `git config --core.excludesFile=<file>`

Then create the file and add itself and the files you want to ignore to it.

This only works for files that hasn't been tracked by git yet.

### ignore file that's already tracked by git

`git rm --cached <file>`

This removes file from Git's tracking(but keep the file locally).

When you do `git status`, git will tell you `deleted: <file>`, but the file is kept in worktree. You'll have to push the deletion to remote through.

Another way is to use `git update-index --skip-worktree <file>` (this way you don't have to include the change in commit, thus don't have to push the change to remote.) To undo, run `git update-index --no-skip-worktree <file>`. To check skip-worktree files, run `git ls-files -v | grep ^S`

