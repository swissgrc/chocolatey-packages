import-module au
import-module PowerShellForGitHub

$repoOwner = 'SonarSource'
$repoName = 'sonarlint-visualstudio'

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
  $release = Get-GitHubRelease -OwnerName $repoOwner -RepositoryName $repoName -Latest
  $version = $release.tag_name
  if ($version.StartsWith('v')) {
    $version = $version.Substring(1)
  }
  
  $asset = Get-GitHubReleaseAsset -OwnerName $repoOwner -RepositoryName $repoName -ReleaseId $release.id | Where-Object name -match 'SonarLint.VSIX-.*-2022.vsix'
  $url = $asset.browser_download_url

  @{
    Version   = $version
    URL32     = $url
    Filename  = "SonarLint.VSIX-${version}-2022"
    FileType  = 'vsix'
  }
}

update -ChecksumFor none
