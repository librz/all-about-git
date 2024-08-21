### 3 scenarios

When merging, there are 3 scenarios:

1. Fast forword. 
2. Branch diverged but no conflicts.
3. Branch diverged & has conflicts. In this case, you'll have to manually resolve merge conflicts, after resolved, you need to manually make a new merge commit.

Fast forword is simple, it simply means fast forword to a later commit. e.g. Branch B are based on branch A, there were some new commits made on branch B, A stays unchanged, when merge B into A, A will just fast forward to latest commit on B.

### Branch diverged - an example

Branch divergence happens because two branches' HEAD used to points to the same commit, but both have separate commit(s) based on this common commit.

Say we have 2 branches: `main` & `feature/style`, `feature/style` is based on `main` branch. Think of the following process:

1. initially, they both have only one commit: `6a711ef feat: add support section to index.html`
2. on `feature/style`, we modified a filed named `index.css` and made a new commit: `daf3137 feat: change body's bg color`
3. on `main`, we modified `index.html` and made a new commit: `492af51 feat: add header to index.html`
4. merge `feature/style` into `main`, git prompt us to make a new merge commit with default message saying: `Merge branch 'feature/style'`, commit to confirm the merge
5. run `git log --all --decorate --oneline --graph`, it showed the following:

<img width="619" alt="Screenshot 2024-01-11 at 16 17 10" src="https://github.com/librz/all-about-git/assets/50607948/d240b2f2-1855-4b8f-aae0-af5411094ce2">

In step 2 & 3, `main` & `feature/style` diverged. In step 4, we merge and a merge commit is generated.

### Conflicts

In the above example, although 2 branches diverged but both were making changes to different files(on `main` branch, `index.html` changed; on `feature/style`, `index.css` changed). Naturally, there are no conflicts.

What if the diverged commits on both branches were touching the same file? Well, there *might* be conflicts!

When there are conflicts, git will inform us by printing something like `Automatic merge failed; fix conflicts and then commit the result.`. If u run `git status`, it'll show something like:

<img width="535" alt="Screenshot 2024-01-17 at 19 05 22" src="https://github.com/librz/all-about-git/assets/50607948/5c7beb87-7b74-4d95-bf1a-0e4389c42091">

Git will also use conflict markers to mark conflict areas in conflicted files, e.g.

```
<<<<<<< HEAD
console.log('hello');
=======
console.log('goodbye');
>>>>>>> feature/new-console-log
```

In this case, change introduced by current branch is `console.log('hello');`, by the other branch is `console.log('goodbye');`. We can choose which change we want to accept, or even accept both changes, once this is decided, we can edit the file, remove conflict markers, add file to staging area & commit.

[git conflict markers](https://stackoverflow.com/questions/7901864/git-conflict-markers)

### Merge strategy

```sh
# accept all incoming changes
git merge -X theirs {branch_name}

# accept all our changes
git merge -X ours {branch_name}
```

see: https://stackoverflow.com/questions/10697463/resolve-git-merge-conflicts-in-favor-of-their-changes-during-a-pull
