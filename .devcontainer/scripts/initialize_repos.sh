#!/bin/bash
set -e

SCRIPT_DIR_INIT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
META_REPO_ROOT=$(realpath "$SCRIPT_DIR_INIT/../..")
PROJECTS_DIR_TARGET="$META_REPO_ROOT/projects"

REPOS_TO_MANAGE=(
  "git@github.com:holchan/AutomaLarWEB.git automalar-web"
)

echo "--- AutomaLar: Initializing Project Repositories into '$PROJECTS_DIR_TARGET' ---"
mkdir -p "$PROJECTS_DIR_TARGET"

for repo_entry in "${REPOS_TO_MANAGE[@]}"; do
  read -r repo_url local_dir_name <<<"$repo_entry"
  target_dir_path="$PROJECTS_DIR_TARGET/$local_dir_name"

  echo "Processing $local_dir_name..."
  if [ -d "$target_dir_path/.git" ]; then
    echo "  '$local_dir_name' already cloned. Attempting to update..."
    (cd "$target_dir_path" && git pull) || echo "  WARN: git pull failed for $local_dir_name. Continuing..."
  elif [ -d "$target_dir_path" ]; then
    echo "  WARN: Directory '$target_dir_path' exists but is not a git repository. Skipping."
  else
    echo "  Cloning '$repo_url' into '$target_dir_path'..."
    git clone "$repo_url" "$target_dir_path" || { echo "  ERROR: Failed to clone $repo_url. Please check URL and permissions. Exiting."; exit 1; }
  fi
done

echo "--- AutomaLar: Repository Initialization Complete ---"