

# Invoke-BobCommand

If Invoke-BobCommand is called from the NuGet package manager console,
it will start a new process to run the command, else it just runs the specified code-block normally.
## Syntax

    Invoke-BobCommand [-Code] <ScriptBlock> [<CommonParameters>]


## Description

`Invoke-BobCommand` can be used to ensure a cmdlet is run in a custom PowerShell
process instead of the package manager console. If it's called from a normal
PowerShell host, it will just run the specified code normally, if it's called
from the package manager host, it will start a new PowerShell process
and rerun the original command with the original parameters.
If the original command has a parameter "ProjectPath" , it will be set with
`Get-ScProjectPath`.





## Parameters

    
    -Code <ScriptBlock>
_The code to execute, when the command is called from a normal PowerShell host.
Normally this will be the whole body of the calling command._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Invoke-BobCommand {Write-Host "Hey"}































