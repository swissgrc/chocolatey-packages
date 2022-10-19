$ErrorActionPreference = 'Stop';

$toolsPath   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$toolsPath\SonarLint.VSIX-6.9.0.54300-2022.vsix"

$packageArgs = @{
  PackageName = $env:ChocolateyPackageName
  VsixUrl     = 'file://' + $filePath.Replace('\', '/')
}

Install-VisualStudioVsixExtension @packageArgs
