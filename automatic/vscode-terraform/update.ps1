Import-Module "AU"

$releases = "https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(terraform@)[^']*" = "`${1}$($Latest.RemoteVersion)"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  if ($download_page.Content -match 'assetUri":"([^"]+)') {
    $assetUri = $Matches[1]
  }
  else {
    throw "Unable to grab asset uri file"
  }

  $json = Invoke-RestMethod -UseBasicParsing -Uri "$assetUri/Microsoft.VisualStudio.Code.Manifest"

  @{
    Version       = $json.version
    RemoteVersion = $json.version
  }
}

update -ChecksumFor none