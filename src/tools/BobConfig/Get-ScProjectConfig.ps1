<#
.SYNOPSIS
Reads the BOB configuration files and returns it as a hashtable
.DESCRIPTION
Reads the BOB configuration files and returns it as a hashtable
Per default the config file is taken from the App_Config/Bob.config file in the current Visual Studio project.
If there is an App_Config/Bob.config.user file, string values will be overwritten by it
and XML elements will be merged.

.PARAMETER ProjectPath
The path of the project for which the config shoud be readed.
If not provided the current Visual Studio project or the *.Website project will be used.
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
                            $childElements = ($node.ChildNodes | ? {$_.NodeType -eq "Element"})
                            if($childElements) {
                                if($config[$node.Name] -and ($config[$node.Name]  -is [Array])) {
                                    foreach($element in $childElements) {
                                        if(-not ($config[$node.Name] | ? {$_.OuterXml -eq $element.OuterXml})) {
                                            $config[$node.Name] += $element
                                        }
                                    }
                                }
                                else {
                                    $config[$node.Name] = @($childElements | % {$_})
                                }
                            }
                            else {
                                $config[$node.Name] = $node.InnerText
                            }
                        }
                    }
                }
            }
        }
        if(-not $config.WebRoot) {
            $config.WebRoot = "$($config.GlobalWebPath)\$($config.WebsiteCodeName)\$($config.WebFolderName)"
        }
        return $config;
    }
}
