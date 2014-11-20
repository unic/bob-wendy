$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"


function global:Get-ScProjectPath { "TestDrive:\"}

Describe "Get-ScProjectConfig" {
  Context "Bob.user.config" {

    $bobConfig = @"
<?xml version="1.0" encoding="utf-8"?>
    <Configuration>
      <WebsiteCodeName>Website code parent</WebsiteCodeName>
      <LocalHostName>local host name code parent</LocalHostName>
    </Configuration>
"@
    $bobUserConfig = @"
<?xml version="1.0" encoding="utf-8"?>
    <Configuration>
      <LocalHostName>local host name code child</LocalHostName>
    </Configuration>
"@
    mkdir "TestDrive:\App_Config"
    $bobConfig | Out-File "TestDrive:\App_Config\Bob.config" -Encoding UTF8
    $bobUserConfig | Out-File "TestDrive:\App_Config\Bob.config.user" -Encoding UTF8


    $config = Get-ScProjectConfig

    It "Should have keep parent value for WebsiteCodeName" {
      $config.WebsiteCodeName | Should Be "Website code parent"
    }

    It "Should have take child value for LocalHostName" {
      $config.LocalHostName | Should Be "local host name code child"
    }
  }

  Context "When there is no WebRoot" {
    $bobConfig = @"
<?xml version="1.0" encoding="utf-8"?>
    <Configuration>
        <GlobalWebPath>D:\web</GlobalWebPath>
      <WebsiteCodeName>website-code</WebsiteCodeName>
      <WebFolderName>dummy</WebFolderName>
    </Configuration>
"@

    mkdir "TestDrive:\App_Config"
    $bobConfig | Out-File "TestDrive:\App_Config\Bob.config" -Encoding UTF8

    $config = Get-ScProjectConfig

    It "WebRoot should be GlobalWebPath + WebsiteCodeName + WebFolderName" {
      $config.WebRoot | Should Be "D:\web\website-code\dummy"
    }
  }

  Context "When there is a WebRoot" {
        $bobConfig = @"
<?xml version="1.0" encoding="utf-8"?>
        <Configuration>
            <GlobalWebPath>D:\dummy</GlobalWebPath>
          <WebsiteCodeName>website-dummy</WebsiteCodeName>
          <WebFolderName>dummy</WebFolderName>
          <WebRoot>D:\veredummy</WebRoot>
        </Configuration>
"@

        mkdir "TestDrive:\App_Config"
        $bobConfig | Out-File "TestDrive:\App_Config\Bob.config" -Encoding UTF8

        $config = Get-ScProjectConfig

        It "Should return the WebRoot" {
            $config.WebRoot | Should Be "D:\veredummy"
        }
    }
}
