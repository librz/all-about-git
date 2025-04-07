Git has build-in CRUD subcommands: `add`, `mv`, `rm`.

Here the parameter of CRUD is files(s)/dir(s) and the destination is the staging area(also called the Index).

`git add` adds file(s) to the staging area. What's the point of `git mv` and `git rm`? How does it diff from normal `mv` & `rm`?

### auto add to staging area

both `git rm` & `git mv` automatically add file(s) to staging area:

```sh
rm test.js
git add test.js
```

is equivalent(more or less) to:

```sh
git rm test.js
```

### avoid casing issues when renaming file(s)

windows/macOS are case-insensitive but case-preserving.

1. case insensitive: `package.json` & `Package.json` refers to the same file
2. case preserving: when renaming a file from `package.json` to `Package.json`, using `ls`, you can see it's name indeed changed (filename is preserved, despite the fact that the file system thinks it's the same file)

Git is originally created for managing Linux source code, so it's case-sensitive by design. The disalignment between windows/mac and git can cause problems, for instance:

```sh
mv package.json Package.json
git status // nothing to commit, working tree clean
```

Solution:

```sh
git mv package.json Package.json
git status // renamed: pakcage.json -> Package.json
```
