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
  "foreign-trade-business-positioning-team" { $TeamFolder = "foreign-trade-business-positioning-team" }
  "enterprise-knowledge-assets-team" { $TeamFolder = "enterprise-knowledge-assets-team" }
  default { throw "Unknown team key: $Team" }
}

if (-not $SourceRoot) {
  $TempName = "accio-agent-teams-" + (Get-Date -Format "yyyyMMddHHmmss") + "-" + (Get-Random)
  $TempDir = Join-Path $env:TEMP $TempName
  New-Item -ItemType Directory -Path $TempDir -Force | Out-Null
  $Archive = Join-Path $TempDir "repo.zip"
  Invoke-WebRequest -Uri $RepoArchiveUrl -OutFile $Archive
  Expand-Archive -LiteralPath $Archive -DestinationPath $TempDir -Force
  $SourceRoot = Get-ChildItem -LiteralPath $TempDir -Directory | Select-Object -First 1 -ExpandProperty FullName
}

$TeamSrc = Join-Path $SourceRoot "packages\$Team"
if (-not (Test-Path -LiteralPath $TeamSrc -PathType Container)) {
  throw "Team source not found: $TeamSrc"
}

if ($AccioTeamRoot) {
  $DestTeam = $AccioTeamRoot
} elseif ($AccioAgentReadyRoot) {
  $DestTeam = Join-Path $AccioAgentReadyRoot "Teams\$TeamFolder"
} else {
  $DestTeam = Join-Path $env:USERPROFILE ".accio\agent-ready\Teams\$TeamFolder"
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
