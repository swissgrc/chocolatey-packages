$ErrorActionPreference = 'Stop';

$toolsPath   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$toolsPath\SonarLint.VSIX-7.2.0.76209-2022.vsix"

$packageArgs = @{
  PackageName = $env:ChocolateyPackageName
  VsixUrl     = 'file://' + $filePath.Replace('\', '/')
}

Install-VisualStudioVsixExtension @packageArgs
