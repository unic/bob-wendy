<div class="chapterlogo">![Wendy](Wendy.jpg)</div>
# Wendy

Wendy is Bob's business partner who runs the office and keeps the business in order, and often organizes tools and equipment. Therefore, Wendy is in charge of the configuration and settings for the machines.

This settings are all saved in the `Bob.config`  file located in the `App_Config`  folder of the `*.Website` project.


## Format
The `Bob.config` is a Xml-File. Each setting should be one child-node of `Configuration`.


## Bob.config.user
Next to `Bob.config` a `Bob.config.user` can be created by each developer for settings which are different on his environment. When a configuration entry is specified in the `Bob.config.user` this setting overwrites the value of `Bob.config`.


## NuGet Package
Each machine which depends on `Bob.config` should have a dependency to _Unic.Bob.Config_. This package adds `Bob.config` and `Bob.config.user` to the project and a [PowerShell module](api/README.md) for reading the config file.
