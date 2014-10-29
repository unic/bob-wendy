function Set-ScUserConfigValue
{
  [CmdletBinding()]
  Param(
      [Parameter(Mandatory=$true)]
      [string]$Key,
      [Parameter(Mandatory=$true)]
      [string]$Value,
      [String]$ProjectPath = "",
      [String]$ConfigFilePath = "App_Config",
      [String[]]$ConfigFileName = @("Bob.config", "Bob.config.user")
  )
  Process
  {
    $ProjectPath = Get-ScProjectPath -ProjectPath $ProjectPath -ConfigFilePath $ConfigFilePath -ConfigFileName $ConfigFileName

    if(-not $ProjectPath) {
      throw "No ProjectPath could be found. Please provide one."
    }

    $path = Join-Path (Join-Path $ProjectPath $ConfigFilePath) "Bob.config.user"
    if(-not (Test-Path $path)) {
      @"
<?xml version="1.0"?>
<Configuration>
</Configuration>
"@ | Out-File $path -Encoding UTF8
    }

    $document = ([xml](Get-Content $path))
    $root = $document.SelectSingleNode("/Configuration")
    if(-not $root) {
    return
      throw "No configuration node in config file $path"
    }

    $node = $root.SelectSingleNode("//$Key")
    if(-not $node) {
      $node = $document.CreateElement($key);
      $root.AppendChild($node)
    }

    $node.InnerText = $value

    $document.Save((Resolve-Path $path))
  }
}
