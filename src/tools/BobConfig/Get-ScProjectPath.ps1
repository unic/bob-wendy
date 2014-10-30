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
