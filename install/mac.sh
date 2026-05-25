#!/usr/bin/env bash
set -euo pipefail

REPO_ARCHIVE_URL="${REPO_ARCHIVE_URL:-https://github.com/chenye1313/accio-agent-teams/archive/refs/heads/main.tar.gz}"
TEAM=""
ACCIO_AGENT_READY_ROOT="${ACCIO_AGENT_READY_ROOT:-}"
ACCIO_TEAM_ROOT="${ACCIO_TEAM_ROOT:-}"
ACCIO_HOME="${ACCIO_HOME:-$HOME/.accio}"
ACCIO_ACCOUNT_ID="${ACCIO_ACCOUNT_ID:-}"
ACCIO_MODEL_PROVIDER="${ACCIO_MODEL_PROVIDER:-accio}"
ACCIO_MODEL_NAME="${ACCIO_MODEL_NAME:-1Nova-bW7yT4kL9pN2}"
ACCIO_MODEL_DISPLAY_NAME="${ACCIO_MODEL_DISPLAY_NAME:-DeepSeek V4 Pro}"
SOURCE_ROOT=""
PACKAGE_ONLY=0

usage() {
  printf '%s\n' "Usage: mac.sh --team <team-key> [--accio-home <path>] [--account-id <id>] [--package-only] [--accio-agent-ready-root <path>] [--team-root <path>] [--source-root <path>]"
}

json_escape() {
  printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'
}

skill_description() {
  local skill_md="$1"
  local desc
  desc="$(sed -n 's/^description:[[:space:]]*//p' "$skill_md" | head -n 1 || true)"
  desc="${desc#\"}"
  desc="${desc%\"}"
  printf '%s' "$desc"
}

write_default_file() {
  local path="$1"
  local title="$2"
  local body="$3"
  if [[ ! -f "$path" ]]; then
    printf '# %s\n\n%s\n' "$title" "$body" > "$path"
  fi
}

clean_role_display_name() {
  local team_code="$1"
  local raw_name="$2"
  local cleaned="$raw_name"

  if [[ "$team_code" == "FTBP" ]]; then
    cleaned="$(printf '%s' "$raw_name" | sed -E 's/^[A-Za-z]+//')"
    if [[ -z "$cleaned" ]]; then
      cleaned="$raw_name"
    fi
  fi

  printf '%s' "$cleaned"
}

preflight_accio_accounts() {
  local accounts_root="$ACCIO_HOME/accounts"
  if [[ ! -d "$accounts_root" ]]; then
    printf 'Accio accounts not found: %s\n' "$accounts_root" >&2
    printf 'Open Accio and sign in once, then run the installer again.\n' >&2
    exit 1
  fi

  if [[ -n "$ACCIO_ACCOUNT_ID" ]]; then
    if [[ ! -d "$accounts_root/$ACCIO_ACCOUNT_ID" ]]; then
      printf 'Accio account not found: %s\n' "$accounts_root/$ACCIO_ACCOUNT_ID" >&2
      printf 'Existing accounts:' >&2
      local existing_account_dir
      while IFS= read -r existing_account_dir; do
        printf ' %s' "$(basename "$existing_account_dir")" >&2
      done < <(find "$accounts_root" -mindepth 1 -maxdepth 1 -type d | sort)
      printf '\n' >&2
      exit 1
    fi
    return
  fi

  local non_guest_count
  non_guest_count="$(find "$accounts_root" -mindepth 1 -maxdepth 1 -type d ! -name guest | wc -l | tr -d ' ')"
  if [[ "$non_guest_count" -eq 0 ]]; then
    printf 'No non-guest Accio account found under: %s\n' "$accounts_root" >&2
    printf 'Open Accio and sign in with the target user, then run the installer again.\n' >&2
    exit 1
  fi
}

register_role_as_agent() {
  local account_dir="$1"
  local role_dir="$2"
  local team_code="$3"
  local team_display="$4"
  local installed_team_dir="$5"
  local role_base role_no display_name agent_id agent_dir core_dir now project_dir

  role_base="$(basename "$role_dir")"
  role_no="${role_base%%_*}"
  if [[ "$role_no" == "$role_base" ]]; then
    role_no="$(printf '%s' "$role_base" | sed 's/[^[:alnum:]]//g' | cut -c1-8)"
  fi
  display_name="${role_base#*_}"
  if [[ "$display_name" == "$role_base" ]]; then
    display_name="$role_base"
  fi
  display_name="$(clean_role_display_name "$team_code" "$display_name")"

  agent_id="MID-AT-${team_code}-${role_no}"
  agent_dir="$account_dir/agents/$agent_id"
  core_dir="$agent_dir/agent-core"
  project_dir="$role_dir"
  now="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"

  if [[ -d "$agent_dir" ]]; then
    mv "$agent_dir" "$agent_dir.backup-$(date +%Y%m%d-%H%M%S)"
  fi

  mkdir -p "$core_dir/skills" "$agent_dir/runtime" "$agent_dir/permissions" "$agent_dir/sessions" "$agent_dir/project"

  [[ -f "$role_dir/identity.md" ]] && cp "$role_dir/identity.md" "$core_dir/IDENTITY.md"
  [[ -f "$role_dir/soul.md" ]] && cp "$role_dir/soul.md" "$core_dir/SOUL.md"
  [[ -f "$role_dir/memory.md" ]] && cp "$role_dir/memory.md" "$core_dir/MEMORY.md"
  [[ -f "$role_dir/user.md" ]] && cp "$role_dir/user.md" "$core_dir/USER.md"
  [[ -f "$role_dir/agents.md" ]] && cp "$role_dir/agents.md" "$core_dir/AGENTS.md"

  write_default_file "$core_dir/IDENTITY.md" "Identity: $display_name" "You are $display_name in $team_display."
  write_default_file "$core_dir/SOUL.md" "Soul: $display_name" "Follow the role contract installed with $team_display."
  write_default_file "$core_dir/MEMORY.md" "Memory: $display_name" "Use the installed Team knowledge and role-local skills as the source of truth."
  write_default_file "$core_dir/USER.md" "User Protocol: $display_name" "Ask only when required inputs are missing. Keep outputs aligned to the role contract."
  write_default_file "$core_dir/AGENTS.md" "Agents: $display_name" "Coordinate with the installed Team roles through the Team workflow."

  cat > "$core_dir/BOOTSTRAP.md" <<EOF
# Bootstrap: $display_name

1. Read IDENTITY.md, SOUL.md, USER.md, MEMORY.md, and AGENTS.md first.
2. Load local skills from agent-core/skills/skills.jsonc when the task matches them.
3. Treat this installed package as the local source of truth:

\`\`\`text
$installed_team_dir
\`\`\`
EOF

  cat > "$core_dir/TOOLS.md" <<'EOF'
# Tools

Use local file tools for installed Team knowledge, and use network/browser tools only when the user task requires fresh external evidence.
EOF

  printf '{\n  "tools": []\n}\n' > "$core_dir/tool-registry.jsonc"
  printf '{\n  "status": "installed"\n}\n' > "$agent_dir/runtime/state.jsonc"
  : > "$agent_dir/permissions/policy.jsonl"
  : > "$agent_dir/permissions/audit.jsonl"

  {
    printf '{\n  "skills": [\n'
    local first=1
    if [[ -d "$role_dir/skills" ]]; then
      while IFS= read -r skill_md; do
        local skill_dir skill_id install_path desc
        skill_dir="$(dirname "$skill_md")"
        skill_id="$(basename "$skill_dir")"
        install_path="$core_dir/skills/$skill_id"
        cp -R "$skill_dir" "$install_path"
        desc="$(skill_description "$skill_md")"
        if [[ "$first" -eq 0 ]]; then
          printf ',\n'
        fi
        first=0
        printf '    {\n'
        printf '      "id": "%s",\n' "$(json_escape "$skill_id")"
        printf '      "name": "%s",\n' "$(json_escape "$skill_id")"
        printf '      "version": "",\n'
        printf '      "enabled": true,\n'
        printf '      "kind": "directory",\n'
        printf '      "entryName": "%s",\n' "$(json_escape "$skill_id")"
        printf '      "description": "%s",\n' "$(json_escape "$desc")"
        printf '      "installPath": "%s"\n' "$(json_escape "$install_path")"
        printf '    }'
      done < <(find "$role_dir/skills" -mindepth 2 -maxdepth 2 -name SKILL.md -type f | sort)
    fi
    printf '\n  ]\n}\n'
  } > "$core_dir/skills/skills.jsonc"

  cat > "$agent_dir/profile.jsonc" <<EOF
// Accio Agent config generated by accio-agent-teams installer.

{
  "id": "$(json_escape "$agent_id")",
  "accountId": "$(json_escape "$(basename "$account_dir")")",
  "name": "$(json_escape "$display_name")",
  "avatar": "",
  "description": "$(json_escape "$display_name from $team_display. Installed from GitHub package $TEAM.")",
  "vibe": "expert",
  "model": {
    "provider": "$(json_escape "$ACCIO_MODEL_PROVIDER")",
    "name": "$(json_escape "$ACCIO_MODEL_NAME")",
    "displayName": "$(json_escape "$ACCIO_MODEL_DISPLAY_NAME")"
  },
  "defaultProject": {
    "dir": "$(json_escape "$project_dir")"
  },
  "runtime": "local",
  "toolInclude": [
    "list",
    "read",
    "grep",
    "glob",
    "ripgrep",
    "write",
    "edit",
    "web_search",
    "web_fetch",
    "bash",
    "process",
    "ask_user",
    "memory_search",
    "memory_get",
    "task_create",
    "task_get",
    "task_update",
    "task_list",
    "sessions_spawn",
    "sessions_list",
    "sessions_history",
    "sessions_send"
  ],
  "creator": "user",
  "agentType": "default",
  "createdAt": "$now",
  "updatedAt": "$now",
  "localMemoryIndex": true
}
EOF

  printf '%s|%s\n' "$agent_id" "$display_name"
}

write_team_conversation() {
  local account_dir="$1"
  local team_code="$2"
  local team_display="$3"
  local installed_team_dir="$4"
  local members_file="$5"
  local conv_dir team_cid now first owner_written

  conv_dir="$account_dir/conversations/team"
  team_cid="CID-AT-${team_code}"
  now="$(date +%s)000"
  mkdir -p "$conv_dir"

  {
    printf '{\n'
    printf '  "id": "%s",\n' "$team_cid"
    printf '  "teamId": "team-%s",\n' "$team_cid"
    printf '  "name": "%s",\n' "$(json_escape "$team_display")"
    printf '  "title": "%s",\n' "$(json_escape "$team_display")"
    printf '  "createdAt": %s,\n' "$now"
    printf '  "updatedAt": %s,\n' "$now"
    printf '  "teamName": "%s",\n' "$(json_escape "$team_display")"
    printf '  "path": "%s",\n' "$(json_escape "$installed_team_dir")"
    printf '  "members": [\n'
    first=1
    owner_written=0
    while IFS='|' read -r agent_id display_name; do
      [[ -z "$agent_id" ]] && continue
      if [[ "$first" -eq 0 ]]; then
        printf ',\n'
      fi
      first=0
      local role="member"
      if [[ "$owner_written" -eq 0 ]]; then
        role="owner"
        owner_written=1
      fi
      printf '    {\n'
      printf '      "id": "%s",\n' "$(json_escape "$agent_id")"
      printf '      "name": "%s",\n' "$(json_escape "$display_name")"
      printf '      "avatar": "",\n'
      printf '      "role": "%s",\n' "$role"
      printf '      "status": "offline",\n'
      printf '      "isAgent": true\n'
      printf '    }'
    done < "$members_file"
    printf '\n  ],\n'
    printf '  "channelMembers": [],\n'
    printf '  "mode": "collaboration",\n'
    printf '  "sessions": [],\n'
    printf '  "delegations": []\n'
    printf '}\n'
  } > "$conv_dir/$team_cid.jsonc"
}

register_accio_team() {
  local installed_team_dir="$1"
  local team_code="$2"
  local team_display="$3"
  local accounts_root="$ACCIO_HOME/accounts"

  if [[ ! -d "$accounts_root" ]]; then
    printf 'Accio accounts not found: %s\n' "$accounts_root" >&2
    printf 'Open Accio and sign in once, then run the installer again.\n' >&2
    exit 1
  fi

  local all_account_dirs=()
  local account_dirs=()
  printf 'Accio home: %s\n' "$ACCIO_HOME"
  printf 'Accio accounts root: %s\n' "$accounts_root"
  while IFS= read -r account_dir; do
    all_account_dirs+=("$account_dir")
  done < <(find "$accounts_root" -mindepth 1 -maxdepth 1 -type d | sort)
  printf 'Accio accounts found:'
  if [[ "${#all_account_dirs[@]}" -eq 0 ]]; then
    printf ' none'
  else
    for account_dir in "${all_account_dirs[@]}"; do
      printf ' %s' "$(basename "$account_dir")"
    done
  fi
  printf '\n'

  if [[ -n "$ACCIO_ACCOUNT_ID" ]]; then
    account_dirs+=("$accounts_root/$ACCIO_ACCOUNT_ID")
  else
    for account_dir in "${all_account_dirs[@]}"; do
      [[ "$(basename "$account_dir")" == "guest" ]] && continue
      account_dirs+=("$account_dir")
    done
  fi

  if [[ "${#account_dirs[@]}" -eq 0 ]]; then
    printf 'No non-guest Accio account found under: %s\n' "$accounts_root" >&2
    exit 1
  fi
  printf 'Target Accio accounts:'
  for account_dir in "${account_dirs[@]}"; do
    printf ' %s' "$(basename "$account_dir")"
  done
  printf '\n'
  printf 'Default model: %s (%s/%s)\n' "$ACCIO_MODEL_DISPLAY_NAME" "$ACCIO_MODEL_PROVIDER" "$ACCIO_MODEL_NAME"

  local total_agents=0
  for account_dir in "${account_dirs[@]}"; do
    if [[ ! -d "$account_dir" ]]; then
      printf 'Accio account not found: %s\n' "$account_dir" >&2
      printf 'Existing accounts:' >&2
      if [[ "${#all_account_dirs[@]}" -eq 0 ]]; then
        printf ' none' >&2
      else
        for existing_account_dir in "${all_account_dirs[@]}"; do
          printf ' %s' "$(basename "$existing_account_dir")" >&2
        done
      fi
      printf '\n' >&2
      exit 1
    fi
    mkdir -p "$account_dir/agents" "$account_dir/conversations/team"
    local members_file
    members_file="$(mktemp)"
    while IFS= read -r role_dir; do
      register_role_as_agent "$account_dir" "$role_dir" "$team_code" "$team_display" "$installed_team_dir" >> "$members_file"
      total_agents=$((total_agents + 1))
    done < <(find "$installed_team_dir/roles" -mindepth 1 -maxdepth 1 -type d | sort)
    write_team_conversation "$account_dir" "$team_code" "$team_display" "$installed_team_dir" "$members_file"
    rm -f "$members_file"
    printf 'Registered Accio account: %s\n' "$(basename "$account_dir")"
    printf 'Agent profile root: %s\n' "$account_dir/agents"
    printf 'Team conversation: %s\n' "$account_dir/conversations/team/CID-AT-${team_code}.jsonc"
  done

  printf 'Registered Accio agents: %s\n' "$total_agents"
  printf 'If agents are not visible in Accio, restart Accio and confirm the signed-in account id is listed above.\n'
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --team)
      TEAM="$2"
      shift 2
      ;;
    --accio-agent-ready-root)
      ACCIO_AGENT_READY_ROOT="$2"
      shift 2
      ;;
    --team-root)
      ACCIO_TEAM_ROOT="$2"
      shift 2
      ;;
    --accio-home)
      ACCIO_HOME="$2"
      shift 2
      ;;
    --account-id)
      ACCIO_ACCOUNT_ID="$2"
      shift 2
      ;;
    --package-only)
      PACKAGE_ONLY=1
      shift
      ;;
    --source-root)
      SOURCE_ROOT="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'Unknown argument: %s\n' "$1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ -z "$TEAM" ]]; then
  usage >&2
  exit 1
fi

case "$TEAM" in
  foreign-trade-business-positioning-team)
    TEAM_NAME="外贸经营定位专家Team"
    TEAM_CODE="FTBP"
    TEAM_DISPLAY="经营定位专家Team"
    ;;
  enterprise-knowledge-assets-team)
    TEAM_NAME="企业知识资产中心Team"
    TEAM_CODE="EKA"
    TEAM_DISPLAY="企业知识资产中心Team"
    ;;
  *)
    printf 'Unknown team key: %s\n' "$TEAM" >&2
    exit 1
    ;;
esac

if [[ -z "$SOURCE_ROOT" ]]; then
  TMP_DIR="$(mktemp -d)"
  ARCHIVE="$TMP_DIR/repo.tar.gz"
  curl -fsSL "$REPO_ARCHIVE_URL" -o "$ARCHIVE"
  tar -xzf "$ARCHIVE" -C "$TMP_DIR"
  SOURCE_ROOT="$(find "$TMP_DIR" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
fi

TEAM_SRC="$SOURCE_ROOT/packages/$TEAM"
if [[ ! -d "$TEAM_SRC" ]]; then
  printf 'Team source not found: %s\n' "$TEAM_SRC" >&2
  exit 1
fi

if [[ "$PACKAGE_ONLY" -eq 0 ]]; then
  preflight_accio_accounts
fi

if [[ -n "$ACCIO_TEAM_ROOT" ]]; then
  DEST_TEAM="$ACCIO_TEAM_ROOT"
elif [[ -n "$ACCIO_AGENT_READY_ROOT" ]]; then
  DEST_TEAM="$ACCIO_AGENT_READY_ROOT/Teams/$TEAM_NAME"
else
  DEST_TEAM="$ACCIO_HOME/agent-ready/Teams/$TEAM_NAME"
fi

mkdir -p "$(dirname "$DEST_TEAM")"

if [[ -d "$DEST_TEAM" ]]; then
  BACKUP="$DEST_TEAM.backup-$(date +%Y%m%d-%H%M%S)"
  mv "$DEST_TEAM" "$BACKUP"
  printf 'Existing team backed up to: %s\n' "$BACKUP"
fi

cp -R "$TEAM_SRC" "$DEST_TEAM"

printf 'Installed team: %s\n' "$DEST_TEAM"
printf 'Role count: %s\n' "$(find "$DEST_TEAM/roles" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
printf 'Skill count: %s\n' "$(find "$DEST_TEAM/roles" -path '*/skills/*/SKILL.md' -type f | wc -l | tr -d ' ')"
printf 'Output guide: %s\n' "$DEST_TEAM/output/README.md"

if [[ "$PACKAGE_ONLY" -eq 0 ]]; then
  register_accio_team "$DEST_TEAM" "$TEAM_CODE" "$TEAM_DISPLAY"
else
  printf 'Accio agent registration skipped because --package-only was set.\n'
fi
