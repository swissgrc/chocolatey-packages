import-module au

$domain = 'https://github.com'
$releases = "$domain/OmniSharp/omnisharp-vscode/releases/latest"

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }
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
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    #https://github.com/OmniSharp/omnisharp-vscode/releases/download/v1.21.0/csharp-1.21.0.vsix
    $re  = "csharp-.+.vsix"
    $url = $download_page.links | Where-Object href -match $re | Select-Object -First 1 -expand href | ForEach-Object { $domain + $_ }
    $file = $url -split '-' | Select-Object -Last 1
    $version = [IO.Path]::GetFileNameWithoutExtension($file)

    @{
        Version = $version
        URL32   = $url
    }
}

update -ChecksumFor none
