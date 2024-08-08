### git help

Similar to Linux's `man` command, Git's CLI offers help on how to use its subcommands. Syntax is `git help <command>`, for instance to find out how to use `git restore` simply do `git help restore`.

To explore git's functionalities, you can do `git help -a` and it will list all available subcommands.

Alternatively, you can use `git <command> -h` syntax, e.g. `git archive -h`

### tldr

`tldr` is a command line utility that can help in finding the most common usages of a command.

It works well with `git` subcommands, for example, to find how to use `git restore`, simply do: `tldr git restore`, and you'll get something like:

```sh
  git restore

  Restore working tree files. Requires Git version 2.23+.
  See also git checkout and git reset.
  More information: https://git-scm.com/docs/git-restore.

  - Restore an unstaged file to the version of the current commit (HEAD):
    git restore path/to/file

  - Restore an unstaged file to the version of a specific commit:
    git restore --source commit path/to/file

  - Discard all unstaged changes to tracked files:
    git restore :/

  - Unstage a file:
    git restore --staged path/to/file

  - Unstage all files:
    git restore --staged :/

  - Discard all changes to files, both staged and unstaged:
    git restore --worktree --staged :/

  - Interactively select sections of files to restore:
    git restore --patch
```

### books

- [Pro Git](https://git-scm.com/book/en/v2)
