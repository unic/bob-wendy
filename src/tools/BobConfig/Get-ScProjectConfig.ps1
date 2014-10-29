<#
.SYNOPSIS
Reads the BOB configuration files and returns it as a hashtable
.DESCRIPTION
Reads the BOB configuration files and returns it as a hashtable
Per default the config file is taken from the App_Config/Bob.config file in the current Visual Studio project. If there is a App_Config/Bob.config.user values will be overriden.

.PARAMETER ProjectPath
The path of the project for which the config shoud be readed.
.PARAMETER ConfigFilePath
The folder in which the config file is located. The path must be relative to the project path.
.PARAMETER ConfigFileName
The names of the config files


.EXAMPLE
Get-ScProjectConfig
.EXAMPLE
Get-ScProjectConfig -ProjectPath D:\projects\Spider\src\Spider.Website
#>

Function Get-ScProjectConfig
{
    [CmdletBinding(
        SupportsShouldProcess=$True,
        ConfirmImpact="Low"
    )]
    Param(
        [String]$ProjectPath = "",
        [String]$ConfigFilePath = "App_Config",
        [String[]]$ConfigFileName = @("Bob.config", "Bob.config.user")
    )
    Begin{}

    Process
    {
        $ProjectPath = Get-ScProjectPath -ProjectPath $ProjectPath -ConfigFilePath $ConfigFilePath -ConfigFileName $ConfigFileName

        if(-not $ProjectPath) {
            throw "No ProjectPath could be found. Please provide one."
        }

        $config = @{
          "WebsitePath" = $ProjectPath
        }
        foreach($configFile in $ConfigFileName) {
          $path = Join-Path (Join-Path $ProjectPath "$ConfigFilePath") "$configFile"
          if(Test-Path $path) {
            Write-Verbose "Read config file $path"
            $xml = [xml](Get-Content $path )
            if($xml.Configuration) {
              foreach($node in $xml.Configuration.ChildNodes) {
                if($node.NodeType -eq "Element") {
                  Write-Verbose "Read config-key $($node.Name) with value $($node.InnerText)"
                  $config[$node.Name] = $node.InnerText
                }
              }
            }
          }
        }
        return $config;
    }
}
