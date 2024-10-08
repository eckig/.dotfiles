Import-Module PSReadLine
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadlineOption -EditMode vi

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
