$ErrorActionPreference = 'Stop';

$toolsPath   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$toolsPath\SonarLint.VSIX-6.10.0.57359-2022.vsix"

$packageArgs = @{
  PackageName = $env:ChocolateyPackageName
  VsixUrl     = 'file://' + $filePath.Replace('\', '/')
}

Install-VisualStudioVsixExtension @packageArgs
