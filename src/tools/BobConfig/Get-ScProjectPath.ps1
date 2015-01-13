<#
.SYNOPSIS
Gets the full path of the Visual Studio Website project with the current context..
.DESCRIPTION
Gets the full path of the Visual Studio Website project with the current context.
There are 3 possibilities how the path can be calculated:
* It is provided as paramter.
* If the current Visual Studio project contains a Bob.config file, the path of the project will be returned.
* If in the current solution there is *.Website project the path of the *.Website project will be returned.

.PARAMETER ProjectPath
If ProjectPath  is provided, it will be returned.
This enables consumers of Get-ScProjectPath to just forward it's $ProjectPath without checking if it was provided.

.PARAMETER ConfigFilePath
The path inside a project where the config files are.

.PARAMETER ConfigFileName
A list of names for config files

.EXAMPLE
Get-ScProjectPath

.EXAMPLE
Get-ScProjectPath -ConfigFilePath App_Config -ConfigFileName Bob.config, Bob.config.user

#>
function Get-ScProjectPath
{
  [CmdletBinding()]
  Param(
      [String]$ProjectPath,
      [String]$ConfigFilePath,
      [String[]]$ConfigFileName
  )
  Process
  {
    if(-not $ProjectPath -and (Get-Command | ? {$_.Name -eq "Get-Project"})) {
        $project = Get-Project
        if($Project) {
            $ProjectPath = Split-Path $project.FullName -Parent
            if(($ConfigFileName | ? {Test-Path (Join-Path (Join-Path $ProjectPath "$ConfigFilePath") "$_")}).Count -eq 0 ) {
              $ProjectPath = ""
            }
        }

        if(-not $ProjectPath) {
          $project = Get-Project "*.Website"
          if($Project) {
            $ProjectPath = Split-Path $project.FullName -Parent
          }
        }
    }

    $ProjectPath
  }
}
