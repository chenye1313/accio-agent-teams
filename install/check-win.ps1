param(
  [string]$AccioHome = $env:ACCIO_HOME
)

$ErrorActionPreference = "Stop"

if (-not $AccioHome) {
  $AccioHome = Join-Path $env:USERPROFILE ".accio"
}

$AccountsRoot = Join-Path $AccioHome "accounts"
Write-Host "Accio home: $AccioHome"
Write-Host "Accounts root: $AccountsRoot"

if (-not (Test-Path -LiteralPath $AccountsRoot -PathType Container)) {
  Write-Host "Accounts root not found. Open Accio and sign in once."
  exit 1
}

$Accounts = @(Get-ChildItem -LiteralPath $AccountsRoot -Directory | Sort-Object Name)
if ($Accounts.Count -eq 0) {
  Write-Host "No accounts found."
  exit 1
}

Write-Host "Accounts found: $((@($Accounts | ForEach-Object { $_.Name })) -join ', ')"

$AnyInstalled = $false
foreach ($Account in $Accounts) {
  Write-Host ""
  Write-Host "Account: $($Account.Name)"
  if ($Account.Name -eq "guest") {
    Write-Host "  guest account: skipped by installer"
    continue
  }

  $AgentsRoot = Join-Path $Account.FullName "agents"
  $TeamRoot = Join-Path (Join-Path $Account.FullName "conversations") "team"

  foreach ($Code in @("EKA", "FTBP")) {
    $Profiles = @()
    if (Test-Path -LiteralPath $AgentsRoot -PathType Container) {
      $Profiles = @(Get-ChildItem -LiteralPath $AgentsRoot -Directory -Filter "MID-AT-$Code-*" | ForEach-Object {
        $Profile = Join-Path $_.FullName "profile.jsonc"
        if (Test-Path -LiteralPath $Profile -PathType Leaf) { $Profile }
      })
    }
    $Conversation = Join-Path $TeamRoot ("CID-AT-" + $Code + ".jsonc")
    $ConversationExists = Test-Path -LiteralPath $Conversation -PathType Leaf
    if ($Profiles.Count -gt 0 -or $ConversationExists) {
      $AnyInstalled = $true
    }
    Write-Host "  Team $Code profiles: $($Profiles.Count)"
    Write-Host "  Team $Code conversation: $ConversationExists"
    if ($Profiles.Count -gt 0) {
      $ModelHitCount = 0
      foreach ($ProfilePath in $Profiles) {
        $Text = Get-Content -LiteralPath $ProfilePath -Raw
        if ($Text -match '"displayName"\s*:\s*"DeepSeek V4 Pro"') {
          $ModelHitCount = $ModelHitCount + 1
        }
      }
      Write-Host "  Team $Code DeepSeek V4 Pro profiles: $ModelHitCount"
    }
  }
}

if ($AnyInstalled) {
  Write-Host ""
  Write-Host "Install files found. If Accio UI does not show them, restart Accio and check current account."
  exit 0
}

Write-Host ""
Write-Host "No installed team files found."
exit 1
