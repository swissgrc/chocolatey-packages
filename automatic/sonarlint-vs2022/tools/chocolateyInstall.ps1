﻿$ErrorActionPreference = 'Stop';

$toolsPath   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$toolsPath\SonarLint.VSIX-7.7.0.86423-2022.vsix"

$packageArgs = @{
  PackageName = $env:ChocolateyPackageName
  VsixUrl     = 'file://' + $filePath.Replace('\', '/')
}

Install-VisualStudioVsixExtension @packageArgs
