### About the `.git` folder

the `.git` folder is the databse of git, if you do `rm -rf .git`, all trakcing done by git will be lost. This is how you can `uninit` a git repo.

several interesting files/folders under `.git` folder

- `config` file: stores all local git configs
- `HEAD` file: HEAD (as its name suggests) refers to the head (latest commit) of current branch you are on
- `refs/heads` folder: stores head(latest commit) of each branch
- `objects` folder: stores objects that git relies upon under the hood (commit, tree & blob)

From the user's perspective, git is a VCS(verion control system). But from the perspective of implementation, git is a file based database. Every commit has an unique hash (primary key) that corresponds to the snapshot (folder structure & file content) at the time of commit. Besides that, a commit also stores the id of its parent commit & things like author & commit mesage.

The DS(data structure) of commit can be defined as:

```typescript
interface Commit {
  id: string;
  parent_commit_id?: string;
  tree_id: string; // reference to project snapshot
  timestamp: string;
  author: string;
  message: string;
  ...
}
```

Notice, commit by itself is very small. That's because it doesn't directly store snapshot information such as folder structure & file content, it simply stores the correspond tree_id & reference the tree.

Tree is a representaion of folder structure, the DS of tree can be defined as:

```typescript
interface Tree {
  id: string;
  // id of file content if it's located directly under "this" folder
  blob_1_id?: string; 
  blob_2_id?: string;
  ...
  // id of sub folder if it's located directly under "this" folder
  sub_tree_1_id?: string; // exist if a sub 
  sub_tree_2_id?: string;
  ...
}
```

As you can see, tree by itself doesn't use a lot of space either. It has an id & reference ids of files & folders under it.

Finally, files are stored as blobs. It's stucture can be defined as:

```typescript
interface Blob {
  id: string;
  content: Binary; // actual file content, if it's text file, you can print it out using `git cat-file -p {{blob id}}`
}
```

More Info: https://git-scm.com/book/en/v2/Git-Internals-Git-Objects

### What's the point of staging area? Why not commit changes in working tree directly?

Fine grained control. Suppose you made a lot of changes in working tree & only want to commit some of changes (maybe because the rest changes are experimental & not ready for commit), you can stage only the changes you want to commit & then commit them.
