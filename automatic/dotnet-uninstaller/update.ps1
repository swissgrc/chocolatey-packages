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

    $ghPath = Get-Command "gh"
    if (!$ghPath) {
      throw "github cli 'gh' installation is required"
    }
    
    # get the latest release (exclude pre-release)
    $releaseJson = gh release view --repo "$repoOwner/$repoName" --json name,tagName,isPrerelease,isDraft,url,publishedAt,assets
    $release = $releaseJson | ConvertFrom-Json
    
    # dont use prerelease or draft releases
    if (($release.isPrerelease) -or ($release.isDraft)) {
      throw "Unexpected release type: prerelease=$($release.isPrerelease), draft=$($release.isDraft)"
    }
  
    # get release asset url
    $assetUrls = $release.assets | Select-Object -ExpandProperty url | Where-Object { $_ -match "dotnet-core-uninstall-.*\.msi" }
    if ($($assetUrls.Length) -ne 1) {
      throw "Found $($assetUrls.Length) assets, expected only one"
    }
    $version = $release.tagName
    if ($version.StartsWith('v')) {
      $version = $version.Substring(1)
    }
    $url = $assetUrls[0]  
    
    @{
      Version   = $version
      URL32     = $url
      Filename  = "dotnet-core-uninstall-${version}"
      FileType  = 'msi'
    }
  }
  
  update -ChecksumFor none -NoCheckChocoVersion
