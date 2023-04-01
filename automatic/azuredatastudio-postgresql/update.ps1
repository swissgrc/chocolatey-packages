import-module au
import-module PowerShellForGitHub

$repoOwner = 'Microsoft'
$repoName = 'azuredatastudio-postgresql'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameBase $Latest.FileName }

function global:au_SearchReplace {
    @{
        ".\legal\verification.txt" = @{
            "(?i)(Download the following extension:.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
            "(?i)(checksum:\s+).*" = "`${1}$($Latest.Checksum32)"
        }
        
        ".\tools\chocolateyInstall.ps1" = @{
            "(extensionVersion\s*=\s*)`"([^*]+)`"" = "`$1`"$($Latest.Version)`""
        }
     }
}

function global:au_GetLatest {
    $release = Get-GitHubRelease -OwnerName $repoOwner -RepositoryName $repoName -Latest
    $version = $release.tag_name
    if ($version.StartsWith('v')) {
      $version = $version.Substring(1)
    }
    
    $asset = Get-GitHubReleaseAsset -OwnerName $repoOwner -RepositoryName $repoName -ReleaseId $release.id | Where-Object name -match 'azuredatastudio-postgresql-.*-win-x64.vsix'
    $url = $asset.browser_download_url
  
    @{
      Version   = $version
      URL32     = $url
      Filename  = "azuredatastudio-postgresql-${version}-win-x64"
      FileType  = 'vsix'
    }
}

update -ChecksumFor none
