Import-Module PSReadLine
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource HistoryAndPlugin

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

# jobs
function jobs
{
  Get-Job
}
function fg
{
  $j = Get-Job -HasMoreData $True -Newest 1
  if($j -ne $null)
  {
    receive-job -Job $j -wait
  }
}

# Visual Studio Vars
function vcvars
{
  & "C:\Program Files (x86)\Microsoft Visual Studio\18\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
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
