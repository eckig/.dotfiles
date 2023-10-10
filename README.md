# .dotfiles

My personal dotfiles - use at your own risk.

# setup

init new repo:

```
git init --bare $HOME/.dotfiles
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config status.showUntrackedFiles no
```

init new machine:
```
git clone --bare <git-repo-url> $HOME/.dotfiles
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config checkout
```
[source](https://news.ycombinator.com/item?id=11070797)

## setup on windows

1. Create powershell file at `$PROFILE` with
```
function config { git --git-dir=$HOME\.dotfiles\ --work-tree=$HOME $args }
```
2. `config checkout`
3. `config config status.showUntrackedFiles no`
4. Set environment variable `XDG_CONFIG_HOME` to `C:\Users\{USER}\.config` ([source](https://vi.stackexchange.com/questions/12579/neovim-setup-on-ms-windows/12596)).

