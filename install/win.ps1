param(
  [Parameter(Mandatory=$true)]
  [string]$Team,
  [string]$AccioAgentReadyRoot = $env:ACCIO_AGENT_READY_ROOT,
  [string]$AccioTeamRoot = $env:ACCIO_TEAM_ROOT,
  [string]$SourceRoot = "",
  [string]$RepoArchiveUrl = "https://github.com/chenye1313/accio-agent-teams/archive/refs/heads/main.zip"
)

$ErrorActionPreference = "Stop"

switch ($Team) {
  "foreign-trade-business-positioning-team" { $TeamName = "外贸经营定位专家Team" }
  "enterprise-knowledge-assets-team" { $TeamName = "企业知识资产中心Team" }
  default { throw "Unknown team key: $Team" }
}

if (-not $SourceRoot -or $SourceRoot.Trim().Length -eq 0) {
  $TempDir = Join-Path ([System.IO.Path]::GetTempPath()) ("accio-agent-teams-" + [System.Guid]::NewGuid().ToString("N"))
  New-Item -ItemType Directory -Path $TempDir -Force | Out-Null
  $Archive = Join-Path $TempDir "repo.zip"
  Invoke-WebRequest -Uri $RepoArchiveUrl -OutFile $Archive
  Expand-Archive -LiteralPath $Archive -DestinationPath $TempDir -Force
  $SourceRoot = (Get-ChildItem -LiteralPath $TempDir -Directory | Select-Object -First 1).FullName
}

$TeamSrc = Join-Path $SourceRoot "packages\$Team"
if (-not (Test-Path -LiteralPath $TeamSrc -PathType Container)) {
  throw "Team source not found: $TeamSrc"
}

if ($AccioTeamRoot -and $AccioTeamRoot.Trim().Length -gt 0) {
  $DestTeam = $AccioTeamRoot
} elseif ($AccioAgentReadyRoot -and $AccioAgentReadyRoot.Trim().Length -gt 0) {
  $DestTeam = Join-Path $AccioAgentReadyRoot "Teams\$TeamName"
} else {
  $DestTeam = Join-Path $env:USERPROFILE ".accio\agent-ready\Teams\$TeamName"
}

$DestParent = Split-Path -Parent $DestTeam
New-Item -ItemType Directory -Path $DestParent -Force | Out-Null

if (Test-Path -LiteralPath $DestTeam -PathType Container) {
  $Backup = "$DestTeam.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
  Move-Item -LiteralPath $DestTeam -Destination $Backup
  Write-Host "Existing team backed up to: $Backup"
}

Copy-Item -LiteralPath $TeamSrc -Destination $DestTeam -Recurse -Force

$RoleCount = (Get-ChildItem -LiteralPath (Join-Path $DestTeam "roles") -Directory | Measure-Object).Count
$SkillCount = (Get-ChildItem -LiteralPath (Join-Path $DestTeam "roles") -Recurse -Filter "SKILL.md" | Where-Object { $_.FullName -match "[\\/\\\\]skills[\\/\\\\]" } | Measure-Object).Count

Write-Host "Installed team: $DestTeam"
Write-Host "Role count: $RoleCount"
Write-Host "Skill count: $SkillCount"
Write-Host "Output guide: $(Join-Path $DestTeam 'output\README.md')"
