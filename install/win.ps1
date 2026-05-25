param(
  [Parameter(Mandatory=$true)]
  [string]$Team,
  [string]$AccioAgentReadyRoot = $env:ACCIO_AGENT_READY_ROOT,
  [string]$AccioTeamRoot = $env:ACCIO_TEAM_ROOT,
  [string]$AccioHome = $env:ACCIO_HOME,
  [string]$AccountId = $env:ACCIO_ACCOUNT_ID,
  [string]$AccioModelProvider = $env:ACCIO_MODEL_PROVIDER,
  [string]$AccioModelName = $env:ACCIO_MODEL_NAME,
  [string]$AccioModelDisplayName = $env:ACCIO_MODEL_DISPLAY_NAME,
  [string]$SourceRoot = "",
  [string]$RepoArchiveUrl = "https://github.com/chenye1313/accio-agent-teams/archive/refs/heads/main.tar.gz",
  [switch]$PackageOnly
)

$ErrorActionPreference = "Stop"

switch ($Team) {
  "foreign-trade-business-positioning-team" {
    $TeamFolder = "foreign-trade-business-positioning-team"
    $TeamCode = "FTBP"
    $TeamDisplay = "foreign-trade-business-positioning-team"
  }
  "enterprise-knowledge-assets-team" {
    $TeamFolder = "enterprise-knowledge-assets-team"
    $TeamCode = "EKA"
    $TeamDisplay = "enterprise-knowledge-assets-team"
  }
  default { throw "Unknown team key: $Team" }
}

if (-not $AccioHome) {
  $AccioHome = Join-Path $env:USERPROFILE ".accio"
}
if (-not $AccioModelProvider) {
  $AccioModelProvider = "accio"
}
if (-not $AccioModelName) {
  $AccioModelName = "1Nova-bW7yT4kL9pN2"
}
if (-not $AccioModelDisplayName) {
  $AccioModelDisplayName = "DeepSeek V4 Pro"
}

function JsonString($Value) {
  if ($null -eq $Value) {
    return '""'
  }
  return ($Value | ConvertTo-Json -Compress)
}

function Write-TextFile($Path, $Lines) {
  $Parent = Split-Path -Parent $Path
  New-Item -ItemType Directory -Path $Parent -Force | Out-Null
  Set-Content -LiteralPath $Path -Value $Lines -Encoding UTF8
}

function Write-DefaultMarkdown($Path, $Title, $Body) {
  if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
    Write-TextFile $Path @("# $Title", "", $Body)
  }
}

function Get-RoleDisplayName($RoleBase, $TeamCode) {
  $Name = $RoleBase -replace "^[^_]*_", ""
  if (-not $Name) {
    $Name = $RoleBase
  }
  if ($TeamCode -eq "FTBP") {
    $Name = $Name -replace "^[A-Za-z]+(?=[\u4e00-\u9fff])", ""
  }
  if (-not $Name) {
    $Name = $RoleBase
  }
  return $Name
}

function Assert-AccioAccountsReady() {
  $AccountsRoot = Join-Path $AccioHome "accounts"
  if (-not (Test-Path -LiteralPath $AccountsRoot -PathType Container)) {
    throw "Accio accounts not found: $AccountsRoot. Open Accio and sign in once, then run the installer again."
  }

  $AllAccountDirs = @(Get-ChildItem -LiteralPath $AccountsRoot -Directory | Sort-Object Name)
  $AllAccountNames = @($AllAccountDirs | ForEach-Object { $_.Name })
  if ($AccountId) {
    $AccountPath = Join-Path $AccountsRoot $AccountId
    if (-not (Test-Path -LiteralPath $AccountPath -PathType Container)) {
      throw "Accio account not found: $AccountPath. Existing accounts: $($AllAccountNames -join ', ')"
    }
  } else {
    $NonGuestAccountDirs = @($AllAccountDirs | Where-Object { $_.Name -ne "guest" })
    if ($NonGuestAccountDirs.Count -eq 0) {
      throw "No non-guest Accio account found under: $AccountsRoot. Open Accio and sign in with the target user, then run the installer again."
    }
  }
}

function Register-RoleAsAgent($AccountDir, $RoleDir, $TeamCode, $TeamDisplay, $InstalledTeamDir) {
  $RoleBase = $RoleDir.Name
  $RoleNo = $RoleBase -replace "_.*$", ""
  $DisplayName = Get-RoleDisplayName $RoleBase $TeamCode
  if (-not $RoleNo) {
    $RoleNo = $RoleBase
  }

  $AgentId = "MID-AT-$TeamCode-$RoleNo"
  $AgentDir = Join-Path (Join-Path $AccountDir.FullName "agents") $AgentId
  $CoreDir = Join-Path $AgentDir "agent-core"
  $ProjectDir = $RoleDir.FullName
  $Now = Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ"

  if (Test-Path -LiteralPath $AgentDir -PathType Container) {
    $Backup = "$AgentDir.backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Move-Item -LiteralPath $AgentDir -Destination $Backup
  }

  New-Item -ItemType Directory -Path (Join-Path $CoreDir "skills") -Force | Out-Null
  New-Item -ItemType Directory -Path (Join-Path $AgentDir "runtime") -Force | Out-Null
  New-Item -ItemType Directory -Path (Join-Path $AgentDir "permissions") -Force | Out-Null
  New-Item -ItemType Directory -Path (Join-Path $AgentDir "sessions") -Force | Out-Null
  New-Item -ItemType Directory -Path (Join-Path $AgentDir "project") -Force | Out-Null

  $CopyMap = @(
    @{ Source = "identity.md"; Dest = "IDENTITY.md" },
    @{ Source = "soul.md"; Dest = "SOUL.md" },
    @{ Source = "memory.md"; Dest = "MEMORY.md" },
    @{ Source = "user.md"; Dest = "USER.md" },
    @{ Source = "agents.md"; Dest = "AGENTS.md" }
  )

  foreach ($Pair in $CopyMap) {
    $SourceFile = Join-Path $RoleDir.FullName $Pair.Source
    $DestFile = Join-Path $CoreDir $Pair.Dest
    if (Test-Path -LiteralPath $SourceFile -PathType Leaf) {
      Copy-Item -LiteralPath $SourceFile -Destination $DestFile -Force
    }
  }

  Write-DefaultMarkdown (Join-Path $CoreDir "IDENTITY.md") "Identity: $DisplayName" "You are $DisplayName in $TeamDisplay."
  Write-DefaultMarkdown (Join-Path $CoreDir "SOUL.md") "Soul: $DisplayName" "Follow the role contract installed with $TeamDisplay."
  Write-DefaultMarkdown (Join-Path $CoreDir "MEMORY.md") "Memory: $DisplayName" "Use the installed Team knowledge and role-local skills as the source of truth."
  Write-DefaultMarkdown (Join-Path $CoreDir "USER.md") "User Protocol: $DisplayName" "Ask only when required inputs are missing. Keep outputs aligned to the role contract."
  Write-DefaultMarkdown (Join-Path $CoreDir "AGENTS.md") "Agents: $DisplayName" "Coordinate with the installed Team roles through the Team workflow."

  Write-TextFile (Join-Path $CoreDir "BOOTSTRAP.md") @(
    "# Bootstrap: $DisplayName",
    "",
    "1. Read IDENTITY.md, SOUL.md, USER.md, MEMORY.md, and AGENTS.md first.",
    "2. Load local skills from agent-core/skills/skills.jsonc when the task matches them.",
    "3. Treat this installed package as the local source of truth:",
    "",
    "```text",
    $InstalledTeamDir,
    "```"
  )

  Write-TextFile (Join-Path $CoreDir "TOOLS.md") @(
    "# Tools",
    "",
    "Use local file tools for installed Team knowledge, and use network/browser tools only when the user task requires fresh external evidence."
  )

  Write-TextFile (Join-Path $CoreDir "tool-registry.jsonc") @("{", "  ""tools"": []", "}")
  Write-TextFile (Join-Path (Join-Path $AgentDir "runtime") "state.jsonc") @("{", "  ""status"": ""installed""", "}")
  Write-TextFile (Join-Path (Join-Path $AgentDir "permissions") "policy.jsonl") @()
  Write-TextFile (Join-Path (Join-Path $AgentDir "permissions") "audit.jsonl") @()

  $SkillLines = @()
  $SkillRoot = Join-Path $RoleDir.FullName "skills"
  if (Test-Path -LiteralPath $SkillRoot -PathType Container) {
    $SkillDirs = Get-ChildItem -LiteralPath $SkillRoot -Directory | Sort-Object Name
    foreach ($SkillDir in $SkillDirs) {
      $SkillMd = Join-Path $SkillDir.FullName "SKILL.md"
      if (Test-Path -LiteralPath $SkillMd -PathType Leaf) {
        $SkillId = $SkillDir.Name
        $InstallPath = Join-Path (Join-Path $CoreDir "skills") $SkillId
        Copy-Item -LiteralPath $SkillDir.FullName -Destination $InstallPath -Recurse -Force
        if ($SkillLines.Count -gt 0) {
          $SkillLines += "    },"
        }
        $SkillLines += "    {"
        $SkillLines += "      ""id"": $(JsonString $SkillId),"
        $SkillLines += "      ""name"": $(JsonString $SkillId),"
        $SkillLines += "      ""version"": """","
        $SkillLines += "      ""enabled"": true,"
        $SkillLines += "      ""kind"": ""directory"","
        $SkillLines += "      ""entryName"": $(JsonString $SkillId),"
        $SkillLines += "      ""description"": """","
        $SkillLines += "      ""installPath"": $(JsonString $InstallPath)"
      }
    }
  }
  if ($SkillLines.Count -gt 0) {
    $SkillLines += "    }"
  }
  $SkillsJson = @("{", "  ""skills"": [") + $SkillLines + @("  ]", "}")
  Write-TextFile (Join-Path (Join-Path $CoreDir "skills") "skills.jsonc") $SkillsJson

  $ProfileLines = @(
    "// Accio Agent config generated by accio-agent-teams installer.",
    "",
    "{",
    "  ""id"": $(JsonString $AgentId),",
    "  ""accountId"": $(JsonString $AccountDir.Name),",
    "  ""name"": $(JsonString $DisplayName),",
    "  ""avatar"": """",",
    "  ""description"": $(JsonString "$DisplayName from $TeamDisplay. Installed from GitHub package $Team."),",
    "  ""vibe"": ""expert"",",
    "  ""model"": {",
    "    ""provider"": $(JsonString $AccioModelProvider),",
    "    ""name"": $(JsonString $AccioModelName),",
    "    ""displayName"": $(JsonString $AccioModelDisplayName)",
    "  },",
    "  ""defaultProject"": {",
    "    ""dir"": $(JsonString $ProjectDir)",
    "  },",
    "  ""runtime"": ""local"",",
    "  ""toolInclude"": [",
    "    ""list"",",
    "    ""read"",",
    "    ""grep"",",
    "    ""glob"",",
    "    ""ripgrep"",",
    "    ""write"",",
    "    ""edit"",",
    "    ""web_search"",",
    "    ""web_fetch"",",
    "    ""bash"",",
    "    ""process"",",
    "    ""ask_user"",",
    "    ""memory_search"",",
    "    ""memory_get"",",
    "    ""task_create"",",
    "    ""task_get"",",
    "    ""task_update"",",
    "    ""task_list"",",
    "    ""sessions_spawn"",",
    "    ""sessions_list"",",
    "    ""sessions_history"",",
    "    ""sessions_send""",
    "  ],",
    "  ""creator"": ""user"",",
    "  ""agentType"": ""default"",",
    "  ""createdAt"": ""$Now"",",
    "  ""updatedAt"": ""$Now"",",
    "  ""localMemoryIndex"": true",
    "}"
  )
  Write-TextFile (Join-Path $AgentDir "profile.jsonc") $ProfileLines

  return "$AgentId|$DisplayName"
}

function Write-TeamConversation($AccountDir, $TeamCode, $TeamDisplay, $InstalledTeamDir, $Members) {
  $ConvDir = Join-Path (Join-Path $AccountDir.FullName "conversations") "team"
  $TeamCid = "CID-AT-$TeamCode"
  $NowMs = "$(Get-Date -UFormat %s)000"
  New-Item -ItemType Directory -Path $ConvDir -Force | Out-Null

  $Lines = @(
    "{",
    "  ""id"": ""$TeamCid"",",
    "  ""teamId"": ""team-$TeamCid"",",
    "  ""name"": $(JsonString $TeamDisplay),",
    "  ""title"": $(JsonString $TeamDisplay),",
    "  ""createdAt"": $NowMs,",
    "  ""updatedAt"": $NowMs,",
    "  ""teamName"": $(JsonString $TeamDisplay),",
    "  ""path"": $(JsonString $InstalledTeamDir),",
    "  ""members"": ["
  )

  $OwnerWritten = $false
  $MemberBlockCount = 0
  foreach ($Member in $Members) {
    $Parts = $Member -split "\|", 2
    $AgentId = $Parts[0]
    $DisplayName = $Parts[1]
    if ($MemberBlockCount -gt 0) {
      $Lines += "    },"
    }
    $Role = "member"
    if (-not $OwnerWritten) {
      $Role = "owner"
      $OwnerWritten = $true
    }
    $Lines += "    {"
    $Lines += "      ""id"": $(JsonString $AgentId),"
    $Lines += "      ""name"": $(JsonString $DisplayName),"
    $Lines += "      ""avatar"": """","
    $Lines += "      ""role"": ""$Role"","
    $Lines += "      ""status"": ""offline"","
    $Lines += "      ""isAgent"": true"
    $MemberBlockCount = $MemberBlockCount + 1
  }
  if ($MemberBlockCount -gt 0) {
    $Lines += "    }"
  }
  $Lines += "  ],"
  $Lines += "  ""channelMembers"": [],"
  $Lines += "  ""mode"": ""collaboration"","
  $Lines += "  ""sessions"": [],"
  $Lines += "  ""delegations"": []"
  $Lines += "}"

  Write-TextFile (Join-Path $ConvDir "$TeamCid.jsonc") $Lines
}

function Register-AccioTeam($InstalledTeamDir, $TeamCode, $TeamDisplay) {
  $AccountsRoot = Join-Path $AccioHome "accounts"
  if (-not (Test-Path -LiteralPath $AccountsRoot -PathType Container)) {
    throw "Accio accounts not found: $AccountsRoot. Open Accio and sign in once, then run the installer again."
  }

  Write-Host "Accio home: $AccioHome"
  Write-Host "Accio accounts root: $AccountsRoot"
  $AllAccountDirs = @(Get-ChildItem -LiteralPath $AccountsRoot -Directory | Sort-Object Name)
  $AllAccountNames = @($AllAccountDirs | ForEach-Object { $_.Name })
  Write-Host "Accio accounts found: $($AllAccountNames -join ', ')"

  if ($AccountId) {
    $AccountPath = Join-Path $AccountsRoot $AccountId
    if (-not (Test-Path -LiteralPath $AccountPath -PathType Container)) {
      throw "Accio account not found: $AccountPath. Existing accounts: $($AllAccountNames -join ', ')"
    }
    $AccountDirs = @(Get-Item -LiteralPath $AccountPath)
  } else {
    $AccountDirs = @($AllAccountDirs | Where-Object { $_.Name -ne "guest" })
  }

  if ($AccountDirs.Count -eq 0) {
    throw "No non-guest Accio account found under: $AccountsRoot. Open Accio and sign in with the target user, then run the installer again."
  }

  $TargetAccountNames = @($AccountDirs | ForEach-Object { $_.Name })
  Write-Host "Target Accio accounts: $($TargetAccountNames -join ', ')"
  Write-Host "Default model: $AccioModelDisplayName ($AccioModelProvider/$AccioModelName)"

  $TotalAgents = 0
  foreach ($AccountDir in $AccountDirs) {
    New-Item -ItemType Directory -Path (Join-Path $AccountDir.FullName "agents") -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path (Join-Path $AccountDir.FullName "conversations") "team") -Force | Out-Null
    $Members = @()
    $RoleRoot = Join-Path $InstalledTeamDir "roles"
    $RoleDirs = Get-ChildItem -LiteralPath $RoleRoot -Directory | Sort-Object Name
    foreach ($RoleDir in $RoleDirs) {
      $Members += Register-RoleAsAgent $AccountDir $RoleDir $TeamCode $TeamDisplay $InstalledTeamDir
      $TotalAgents = $TotalAgents + 1
    }
    Write-TeamConversation $AccountDir $TeamCode $TeamDisplay $InstalledTeamDir $Members
    Write-Host "Registered Accio account: $($AccountDir.Name)"
    Write-Host "Agent profile root: $(Join-Path $AccountDir.FullName 'agents')"
    $TeamConversationPath = Join-Path (Join-Path (Join-Path $AccountDir.FullName "conversations") "team") ("CID-AT-" + $TeamCode + ".jsonc")
    Write-Host "Team conversation: $TeamConversationPath"
  }

  Write-Host "Registered Accio agents: $TotalAgents"
  Write-Host "If agents are not visible in Accio, restart Accio and confirm the signed-in account id is listed above."
}

if (-not $SourceRoot) {
  $TempName = "accio-agent-teams-" + (Get-Date -Format "yyyyMMddHHmmss") + "-" + (Get-Random)
  $TempDir = Join-Path $env:TEMP $TempName
  New-Item -ItemType Directory -Path $TempDir -Force | Out-Null
  $Archive = Join-Path $TempDir "repo.tar.gz"
  Invoke-WebRequest -UseBasicParsing -Uri $RepoArchiveUrl -OutFile $Archive
  $Tar = Get-Command tar.exe -ErrorAction SilentlyContinue
  if (-not $Tar) {
    throw "tar.exe not found. Windows 10 1803+ includes tar.exe. Update Windows, or install from a local cloned source with -SourceRoot."
  }
  & tar.exe -xzf $Archive -C $TempDir
  if ($LASTEXITCODE -ne 0) {
    throw "Failed to extract repository archive with tar.exe. Archive: $Archive"
  }
  $SourceRoot = Get-ChildItem -LiteralPath $TempDir -Directory | Select-Object -First 1 -ExpandProperty FullName
}

$TeamSrc = Join-Path $SourceRoot "packages\$Team"
if (-not (Test-Path -LiteralPath $TeamSrc -PathType Container)) {
  throw "Team source not found: $TeamSrc"
}

if (-not $PackageOnly) {
  Assert-AccioAccountsReady
}

if ($AccioTeamRoot) {
  $DestTeam = $AccioTeamRoot
} elseif ($AccioAgentReadyRoot) {
  $DestTeam = Join-Path $AccioAgentReadyRoot "Teams\$TeamFolder"
} else {
  $DestTeam = Join-Path $AccioHome "agent-ready\Teams\$TeamFolder"
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

if ($PackageOnly) {
  Write-Host "Accio agent registration skipped because -PackageOnly was set."
} else {
  Register-AccioTeam $DestTeam $TeamCode $TeamDisplay
}
