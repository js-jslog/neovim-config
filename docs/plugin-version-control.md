# Plugin version control

## Manual control shouldn't be necessary but...

The lazy plugin manager claims to ensure stable plugin versioning using it's lazy-lock.json.

This is fair enough, but it's not particularly deliberate from my side, and I wonder whether it might
make upgrading individual plugins harder when you want to experiment with unbinding the plugins from
the version specified in the lazy-lock.json.

I've decided to be specific about plugin version in my config using the `tag` or `commit` keywords.
See the lua/jslog/plugins/install.lua for the complete set of plugin install definitions.

## Some quirky behaviour to keep an eye on

One quirk here is that for some plugins, specifying the commit id which is at the HEAD of the default
branch will mean that `git status` in that project cloned by lazy will report that the branch is
checked out rather than the intended commit.

I have tested that there isn't something wrong with these projects by setting lazy to acquire the
second most recent commit instead, and in that case the `git status` command gives the expected
response.

## Actions for the future

In case there is any doubt in the future, this is the folder that lazy clones the plugins to:

```
~/.local/share/nvim/lazy/
```

If you want to delete everything which could need deleting to do a fresh install then it's this:

```
# Make sure you have closed nvim before doing this
# or the subsequent install could fail
rm -rf ~/.config/nvim/lazy-lock.json && rm -rf ~/.local/share/nvim && rm -rf ~/.local/state/nvim
```

A quick check of which projects are checkedout on a main or master branch can be performed like this:

```
cd ~/.local/share/nvim/lazy/
for dir in */; do if [ -d "$dir" ]; then branch=$(cd "$dir" && git rev-parse --abbrev-ref HEAD); if [ "$branch" = "master" ] || [ "$branch" = "main" ]; then echo "$dir"; fi; fi; done
```

You will get some results from this, and that is in line with what has been reported above.

At the time of writing the list of results is the following:

- FixCursorHold.nvim/
- cmp-nvim-lsp/
- harpoon/
- neotest-jest/
- noice.nvim/
- nvim-cmp/
- undotree/
- vim-fugitive/
- workspace-diagnostics.nvim/

By the time you come to review this again I would expect this list to have reduced since the HEAD
commit should have moved on. For any which remain I would suggest checking that there have not been
any new commits since today (21/05/24). If there have then it does suggest that there's a problem
with some aspect of this version control system.

I would also suggest occasionally deleting the lazy-lock.json and making sure that it's always
reproduced identically to how it was before. This would confirm that we're not dependant on it for
pinning versions successfully, and that we can therefore simply delete it at the start of each
plugin upgrade session.
