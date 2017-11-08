# Wendy - API

##  Get-ScProjectConfig
Reads the BOB configuration files and returns it as a hashtable    
    
    Get-ScProjectConfig [[-ProjectPath] <String>] [[-ConfigFileName] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]


 [Read more](Get-ScProjectConfig.md)
##  Get-ScProjectPath
Gets the full path of the Visual Studio Website project with the current context.    
    
    Get-ScProjectPath [[-ProjectPath] <String>] [[-ConfigFileName] <String[]>] [<CommonParameters>]


 [Read more](Get-ScProjectPath.md)
##  Invoke-BobCommand
If Invoke-BobCommand is called from the NuGet package manager console,
it will start a new process to run the command, else it just runs the specified code-block normally.    
    
    Invoke-BobCommand [-Code] <ScriptBlock> [<CommonParameters>]


 [Read more](Invoke-BobCommand.md)
##  Set-ScUserConfigValue
Sets a config value in the Bob.config.user    
    
    Set-ScUserConfigValue [-Key] <String> [-Value] <String> [[-ProjectPath] <String>] [[-ConfigFileName] <String[]>] [<CommonParameters>]


 [Read more](Set-ScUserConfigValue.md)

