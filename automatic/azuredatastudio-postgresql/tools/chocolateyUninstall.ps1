$ErrorActionPreference = 'Stop'

Update-SessionEnvironment

Uninstall-AzureDataStudioExtension -extensionId "microsoft.azuredatastudio-postgresql"