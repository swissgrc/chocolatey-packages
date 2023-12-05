$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$extensionName = "azuredatastudio-postgresql-"
$extensionVersion = "0.6.0"
$extensionId = "$toolsDir\$extensionName$extensionVersion-win-x64.vsix"

Update-SessionEnvironment

Install-AzureDataStudioExtension -extensionId $extensionId
