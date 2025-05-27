$ErrorActionPreference = 'Stop'; 

$toolsPath   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$toolsPath\dotnet-core-uninstall-1.7.618124.msi"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'msi' 
  file         = Get-Item $filePath

  softwareName  = 'Microsoft .NET Core SDK Uninstall Tool*' 

  silentArgs    = "/quiet /norestart" 
  validExitCodes= @(0, 3010, 1641)
}
Install-ChocolateyInstallPackage @packageArgs 
