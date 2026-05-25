param(
  [Parameter(Mandatory=$true)]
  [string]$Team,
  [string]$Label = "local"
)

$ErrorActionPreference = "Stop"

$InstallDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Split-Path -Parent $InstallDir
$Installer = Join-Path $InstallDir "win.ps1"
$Stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$LogPath = Join-Path $RepoRoot ("install-log-" + $Label + "-" + $Stamp + ".txt")
$TranscriptStarted = $false

try {
  Start-Transcript -Path $LogPath -Force | Out-Null
  $TranscriptStarted = $true
} catch {
  Write-Host "Could not start transcript log: $($_.Exception.Message)"
}

try {
  Write-Host "Accio Agent Teams local installer"
  Write-Host "Repo root: $RepoRoot"
  Write-Host "Team: $Team"
  Write-Host "Log file: $LogPath"

  if (-not (Test-Path -LiteralPath $Installer -PathType Leaf)) {
    throw "Installer not found: $Installer"
  }
  if (-not (Test-Path -LiteralPath (Join-Path $RepoRoot "packages") -PathType Container)) {
    throw "packages folder not found under: $RepoRoot"
  }
  if (-not (Test-Path -LiteralPath (Join-Path $RepoRoot "packages\$Team") -PathType Container)) {
    throw "Team package not found under packages: $Team"
  }

  & $Installer -Team $Team -SourceRoot $RepoRoot
  if (-not $?) {
    throw "Installer returned failure."
  }

  Write-Host "Local install finished."
  exit 0
} catch {
  Write-Host "Local install failed: $($_.Exception.Message)"
  Write-Host "Please send this log file: $LogPath"
  exit 1
} finally {
  if ($TranscriptStarted) {
    try {
      Stop-Transcript | Out-Null
    } catch {
    }
  }
}
