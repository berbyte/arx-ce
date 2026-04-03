# ARX installer

Public install script and release mirror for the **arx-hook** CLI.

## Install

```bash
curl -fsSL https://get.arx.ber.run/install | bash
```

Optional: set `ARX_VERSION`, `ARX_BIN_DIR`, or `ARX_REPO` — see comments in [`install.sh`](install.sh).

On Cloudflare Pages, serve this file at path **`/install`** (same content as `install.sh`).
