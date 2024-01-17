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

What if the diverged commits on both branches were touching the same file? Well, there will be conflicts & we have to manually resolve them.
