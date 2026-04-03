#!/usr/bin/env bash
# Install the ARX telemetry binary from GitHub releases (GoReleaser artifacts).
#
# Unix / macOS / Git Bash on Windows:
#   curl -fsSL https://get.arx.ber.run/install | bash
#
# Native Windows (PowerShell 5.1+):
#   irm https://raw.githubusercontent.com/berbyte/arx-installer/main/install.ps1 | iex
#
# Environment (optional):
#   ARX_REPO              GitHub repo as owner/name (default: berbyte/arx-installer)
#   ARX_VERSION           Release tag or bare semver (e.g. v1.2.3 or 1.2.3). Default: latest GitHub release.
#   ARX_BIN_DIR           Install directory (default: $HOME/.local/bin)
#   ARX_SKIP_PATH_HINT     Set to 1 to silence ~/.local/bin PATH reminder
#   ARX_POST_INSTALL      If set, run after install: words become extra args (e.g. "install cursor").
#                          When you add a top-level `arx-hook install` that probes tools, set e.g.
#                          ARX_POST_INSTALL=install or ARX_POST_INSTALL="install --all".
#   ARX_GITHUB_API         Override GitHub API base (default: https://api.github.com)

set -euo pipefail

ARX_REPO="${ARX_REPO:-berbyte/arx-installer}"
ARX_BIN_DIR="${ARX_BIN_DIR:-$HOME/.local/bin}"
ARX_SKIP_PATH_HINT="${ARX_SKIP_PATH_HINT:-0}"
ARX_GITHUB_API="${ARX_GITHUB_API:-https://api.github.com}"

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "arx-hook install: required command not found: $1" >&2
    exit 1
  }
}

# Strip leading v/V for GoReleaser archive semver segment.
semver_file() {
  local v="$1"
  echo "${v#[vV]}"
}

ensure_tag() {
  local v="$1"
  if [[ "$v" == [vV]* ]]; then
    echo "$v"
  else
    echo "v${v}"
  fi
}

detect_os() {
  case "$(uname -s)" in
  Linux*) echo linux ;;
  Darwin*) echo darwin ;;
  MINGW* | MSYS* | CYGWIN*) echo windows ;;
  *)
    echo "arx-hook install: unsupported OS: $(uname -s)" >&2
    exit 1
    ;;
  esac
}

detect_arch() {
  case "$(uname -m)" in
  x86_64 | amd64) echo amd64 ;;
  aarch64 | arm64) echo arm64 ;;
  *)
    echo "arx-hook install: unsupported CPU: $(uname -m)" >&2
    exit 1
    ;;
  esac
}

fetch_latest_tag() {
  need_cmd curl
  local json
  json="$(curl -fsSL \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "${ARX_GITHUB_API}/repos/${ARX_REPO}/releases/latest")"
  local tag
  tag="$(printf '%s\n' "$json" | sed -n 's/.*"tag_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n1)"
  if [[ -z "$tag" ]]; then
    echo "arx-hook install: could not parse latest release tag for ${ARX_REPO}" >&2
    exit 1
  fi
  printf '%s\n' "$tag"
}

main() {
  need_cmd mkdir
  need_cmd chmod

  local os arch
  os="$(detect_os)"
  arch="$(detect_arch)"

  local tag ver
  if [[ -n "${ARX_VERSION:-}" ]]; then
    tag="$(ensure_tag "$ARX_VERSION")"
    ver="$(semver_file "$ARX_VERSION")"
  else
    tag="$(fetch_latest_tag)"
    ver="$(semver_file "$tag")"
  fi

  local ext unpack_bin
  if [[ "$os" == windows ]]; then
    ext="zip"
    unpack_bin="arx-hook.exe"
    # BSD/GNU tar on Windows 10+ and Git Bash extracts zip; avoids a separate unzip dependency.
    need_cmd tar
  else
    ext="tar.gz"
    unpack_bin="arx-hook"
    need_cmd tar
  fi

  # GoReleaser name_template: {{ .ProjectName }}_{{ .Version }}_{{ .Os }}_{{ .Arch }}
  local asset="arx-hook_${ver}_${os}_${arch}.${ext}"
  local url="https://github.com/${ARX_REPO}/releases/download/${tag}/${asset}"

  local tmpdir
  tmpdir="$(mktemp -d)"
  trap 'rm -rf "$tmpdir"' EXIT

  echo "Downloading ${url} ..."
  curl -fL --retry 3 --retry-delay 1 -o "${tmpdir}/bundle.${ext}" "$url"

  mkdir -p "$ARX_BIN_DIR"
  local dest="${ARX_BIN_DIR}/arx-hook"
  if [[ "$os" == windows ]]; then
    dest="${ARX_BIN_DIR}/arx-hook.exe"
    mkdir -p "$tmpdir/out"
    tar -xf "${tmpdir}/bundle.${ext}" -C "$tmpdir/out"
    local win_found=""
    if [[ -f "${tmpdir}/out/${unpack_bin}" ]]; then
      win_found="${tmpdir}/out/${unpack_bin}"
    else
      win_found="$(find "$tmpdir/out" -type f -name "${unpack_bin}" | head -n1)"
    fi
    if [[ -z "$win_found" || ! -f "$win_found" ]]; then
      echo "arx-hook install: expected ${unpack_bin} not found in archive" >&2
      exit 1
    fi
    mv "$win_found" "$dest"
  else
    tar -xzf "${tmpdir}/bundle.${ext}" -C "$tmpdir"
    local found=""
    if [[ -f "${tmpdir}/${unpack_bin}" ]]; then
      found="${tmpdir}/${unpack_bin}"
    else
      found="$(find "$tmpdir" -type f -name "${unpack_bin}" | head -n1)"
    fi
    if [[ -z "$found" || ! -f "$found" ]]; then
      echo "arx-hook install: expected ${unpack_bin} not found in archive" >&2
      exit 1
    fi
    mv "$found" "$dest"
  fi

  chmod +x "$dest"

  echo "Installed: $dest"

  if [[ "$ARX_SKIP_PATH_HINT" != "1" && ":${PATH}:" != *":${ARX_BIN_DIR}:"* ]]; then
    echo "Note: add ${ARX_BIN_DIR} to your PATH, e.g.:"
    if [[ "$os" == windows ]]; then
      echo "  Git Bash: export PATH=\"${ARX_BIN_DIR}:\$PATH\""
      echo "  PowerShell: \$env:Path = \"${ARX_BIN_DIR};\" + \$env:Path"
      echo "  Or run the Windows installer: irm .../scripts/install.ps1 | iex"
    else
      echo "  export PATH=\"${ARX_BIN_DIR}:\$PATH\""
    fi
  fi

  if [[ -n "${ARX_POST_INSTALL:-}" ]]; then
    read -r -a post_args <<<"$ARX_POST_INSTALL"
    echo "Running: $dest ${post_args[*]}"
    "$dest" "${post_args[@]}"
  fi
}

main "$@"
