# Bob.config

The bob tools all needs some settings. This settings are all saved in the *Bob.config*  file located in the *App_Config*  folder of the *\*.Website* project.

## Format 
The Bob.config is a Xml-File. Each setting should be one child-node of *Configuration*.

## Bob.config.user
Next to Bob.config a Bob.config.user can be created by each developer for settings which are different on his environment. When a configuration entry is specified in the Bob.config.user  this overwrites the value of Bob.config.

## NuGet package
Each tool which depends on Bob.config should have a dependency to Unic.Bob.Config. This package adds Bob.config and Bob.config.user to the project and a [PowerShell module](api/README.md) for reading the config.
