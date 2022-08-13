import-module au

$releases = 'https://github.com/SonarSource/sonarlint-visualstudio/releases'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameBase $Latest.FileName }

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(1\..+)\<.*\>"         = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum type:\s+).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(checksum:\s+).*"      = "`${1} $($Latest.Checksum32)"
    }
    'tools\chocolateyInstall.ps1' = @{
      "(^[$]filePath\s*=\s*`"[$]toolsPath\\)(.*)`"" = "`$1$($Latest.FileName).$($Latest.FileType)`""
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re      = 'SonarLint.VSIX-.*-2022.vsix'
  $url     = "https://github.com" + ($download_page.links | Where-Object href -match $re | Select-Object -First 1 -expand href)
  $version = $url -split '-' | Select-Object -Last 1 -Skip 1

  @{
    Version   = $version
    URL32     = $url
    Filename  = "SonarLint.VSIX-${version}-2022"
    FileType  = 'vsix'
  }
}

update -ChecksumFor none
