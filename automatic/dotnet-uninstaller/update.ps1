import-module au

$repoOwner = 'dotnet'
$repoName = 'cli-lab'

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
    
    $asset = Get-GitHubReleaseAsset -OwnerName $repoOwner -RepositoryName $repoName -ReleaseId $release.id | Where-Object name -match 'dotnet-core-uninstall.msi'
    $url = $asset.browser_download_url
  
    if (!$url) {
      throw "Asset not found"
    }

    @{
      Version   = $version
      URL32     = $url
      Filename  = "dotnet-core-uninstall-${version}"
      FileType  = 'msi'
    }
  }
  
  update -ChecksumFor none -NoCheckChocoVersion
