

# Get-ScProjectPath

Gets the full path of the Visual Studio Website project with the current context.
## Syntax

    Get-ScProjectPath [[-ProjectPath] <String>] [[-ConfigFileName] <String[]>] [<CommonParameters>]


## Description

Gets the full path of the Visual Studio Website project with the current context.
There are 3 possibilities how the path can be calculated:
* It is provided as parameter.
* If the current Visual Studio project contains a Bob.config file, the path of the project will be returned.
* If the current solution contains a *.Website project, the path of the *.Website project will be returned.





## Parameters

    
    -ProjectPath <String>
_If ProjectPath  is provided, it will be returned.
This enables consumers of Get-ScProjectPath to just forward their ProjectPath-parameter to Get-ScProjectPath without checking if it was provided._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | false |  | false | false |


----

    
    
    -ConfigFileName <String[]>
_A list of names for config files_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | false | @("Bob.config", "Bob.config.user") | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Get-ScProjectPath






























### -------------------------- EXAMPLE 2 --------------------------
    Get-ScProjectPath -ConfigFileName Bob.config, Bob.config.user































