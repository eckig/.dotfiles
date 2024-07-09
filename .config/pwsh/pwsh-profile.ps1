Import-Module PSReadLine
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-Alias -Name n -Value nvim
Set-Alias -Name lg -Value lazygit

# Useful shortcuts for traversing directories
function ... { Set-Location ..\.. }
function .. { Set-Location ..\ }

# dotfiles alias
function config
{
  git --git-dir=$HOME\.dotfiles\ --work-tree=$HOME $args
}
function ly
{
  lazygit --git-dir=$HOME\.dotfiles\ --work-tree=$HOME
}
function jobs
{
  Get-Job
}

# scoop update and cleanup
function scup
{
  scoop update *
  scoop cleanup *
  scoop cache rm *
}

function which($name)
{
  Get-Command $name | Select-Object -ExpandProperty Definition
}
