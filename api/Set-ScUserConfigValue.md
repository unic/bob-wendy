

# Set-ScUserConfigValue

Sets a config value in the Bob.config.user
## Syntax

    Set-ScUserConfigValue [-Key] <String> [-Value] <String> [[-ProjectPath] <String>] [[-ConfigFileName] <String[]>] [<CommonParameters>]


## Description

Sets a config value in the current Bob.config.user.
If the file does not exist yet, it will be created.
If the Bob.config.user does not contain a Key yet, it will be added.





## Parameters

    
    -Key <String>
_The config key to set_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -Value <String>
_The value to set._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -ProjectPath <String>
_If specified, the Bob.config.user will be searched inside this path._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | false |  | false | false |


----

    
    
    -ConfigFileName <String[]>
_A list of config file names which will be used to find the correct project, when no ProjectPath was provided._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | false | @("Bob.config", "Bob.config.user") | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    































