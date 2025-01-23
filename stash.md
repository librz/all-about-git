stash changes that are not ready for commit & you may need to come back to it later

git stashes are organized as a **stack** which is FILO(First In Last Out)

#### inspect

- list: `git stash list`
- show changes in a stash: `git stash show stash@{index}`

#### push

- stash changes(tracked files only): `git stash`
- stash changes in tracked files & give it a message: `git stash -m "to be continued"`
- stash changes(including untracked files): `git stash -u` or `git stash --include-untracked`

#### apply and pop

- apply stash: `git stash apply stash@{index}`, stash name is optional, default is `stash@{0}` which is the latest stash
- pop stash out of stack: `git stash pop stash@{index}`, not only apply the stash but also remove it from stash list. (again, stash name is optional)

#### drop

- drop specific stash: `git stash drop stash@{index}`
- drop all stashes: `git stash clear`
