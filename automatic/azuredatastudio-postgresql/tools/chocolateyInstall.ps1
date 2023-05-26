$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$extensionName = "azuredatastudio-postgresql-"
$extensionVersion = "0.3.1"
$extensionId = "$toolsDir\$extensionName$extensionVersion-win-x64.vsix"

Update-SessionEnvironment

Install-AzureDataStudioExtension -extensionId $extensionId
