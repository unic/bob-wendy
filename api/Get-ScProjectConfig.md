

# Get-ScProjectConfig

Reads the BOB configuration files and returns it as a hashtable
## Syntax

    Get-ScProjectConfig [[-ProjectPath] <String>] [[-ConfigFileName] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]


## Description

Reads the BOB configuration files and returns it as a hashtable
Per default the config file is taken from the the first Bob.config that we come across going from where we are upwards.
When there is a Bob.config.user file, string values will be overwritten by it
and XML elements will be merged.





## Parameters

    
    -ProjectPath <String>
_The path of the project for which the config should be read.
If not provided the current Visual Studio project or the *.Website project will be used._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | false |  | false | false |


----

    
    
    -ConfigFileName <String[]>
_The names of the config files_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | false | @("Bob.config", "Bob.config.user") | false | false |


----

    
    
    -WhatIf <SwitchParameter>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| named | false |  | false | false |


----

    
    
    -Confirm <SwitchParameter>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| named | false |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Get-ScProjectConfig






























### -------------------------- EXAMPLE 2 --------------------------
    Get-ScProjectConfig -ProjectPath D:\projects\Spider\src\Spider.Website































