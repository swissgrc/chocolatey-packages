$ErrorActionPreference = 'Stop'

Update-SessionEnvironment

Uninstall-VsCodeExtension -extensionId "ms-dotnettools.csharp"
