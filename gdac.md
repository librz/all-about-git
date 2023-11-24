### What is gdac

`gdac` (short for `git discard all changes`) is a shell function that I wrote to forfeit all changes since last commit. Here's what it does:

```sh
function gdac() {
    # clean untracked files & directories
    git clean -df
    # discard all changes in tracked files by checking out HEAD
    # u can also use `git restore .` to achieve the same effect
    git checkout -- .
}
```

It's a good opportunity to study when/how to use `git clean` & `git restore`

### File status in Git

To git, a file has 2 status: tracked & untrakced

1. tracked: a file is known to git (staged/committed)
2. untrakced: a file is not yet known to git (new file that is not staged/committed)

### git clean

`git clean` can only take effect on untracked files. It simply removes all untracked files.

- `git clean -f` (f means force, just a safe mechanism)
- `git clean -fd` (also remove untracked directories along with untracked files)

### git restore

`git restore` can only take effect on tracked files. Depending on file status, the word `restore` has different meanings:

1. file is modified but not yet staged: restore means restore the file to last commit. `git restore <file>`
2. file is created/modified & staged: restore simply means unstage, it does NOT change content of the file. e.g. `git restore --staged <file>`

note: when using `git restore`, u must specify its scope(files/directory)
