<#
.SYNOPSIS
If Invoke-BobCommand is called from the NuGet package manager console,
it will start a new process to run the command, else it just runs the specified code-block normally.

.DESCRIPTION
`Invoke-BobCommand` can be used to ensure a cmdlet is run in a custom PowerShell
process instead of the package manager console. If it's called from a normal
PowerShell host, it will just run the specified code normally, if it's called
from the package manager host, it will start a new PowerShell process
and rerun the original command with the original parameters.
If the original command has a parameter "ProjectPath" , it will be set with
`Get-ScProjectPath`.

.PARAMETER Code
The code to execute, when the command is called from a normal PowerShell host.
Normally this will be the whole body of the calling command.

.EXAMPLE
Invoke-BobCommand {Write-Host "Hey"}


#>
function Invoke-BobCommand
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [ScriptBlock] $Code
    )
    Process
    {
        if($host.Name -eq "Package Manager Host") {
            $caller = (Get-PSCallStack)[1]
            $command = Get-Command $caller.Command
            $module = $command.Module.Path
            $parameters = $caller.InvocationInfo.BoundParameters
            $newCommand = $caller.Command
            foreach($key in $parameters.Keys) {
                $value = $parameters[$key]

                if($command.Parameters[$key].ParameterType -eq [System.Management.Automation.SwitchParameter]) {
                    $newCommand += " -${Key}:`$$value"
                }
                else {
                    $escapedValue = $value -replace "'", "``'"
                    $newCommand += " -${Key} '$escapedValue'"
                }
            }

            if(-not ($caller.InvocationInfo.BoundParameters["ProjectPath"])) {
                $projectPath = Get-ScProjectPath
                $newCommand += " -ProjectPath $projectPath"
            }

            Write-Verbose $newCommand
            Write-Debug "Restart with module $module"

            # 'sysnative' will force to start a x64 PowerShell which is way cooler :)
            C:\Windows\sysnative\WindowsPowerShell\v1.0\powershell.exe -NoProfile -NoLogo {
                param($module, $command)
                try {
                    Import-Module $module
                    iex $command
                }
                catch {
                    if($_.Exception -is [Microsoft.PowerShell.Commands.WriteErrorException]) {
                        Write-Error ("`n" + $_.ToString())
                    }
                    else {
                        Write-Error ("`n" + $_.ToString() + "`n"+ $_.ScriptStackTrace)
                    }

                }
            } -args $module, $newCommand
        }
        else {
            & $Code
        }
    }
}
