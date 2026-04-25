# ttyd-btop-privileged is deprecated

This project has been merged into [**ttyd-tops**](https://github.com/btleffler/ttyd-tops) — a single image that supports `top`, `htop`, `btop`, `atop`, and `bottom` with runtime-controlled privilege.

## Drop-in replacement

The new image runs as an unprivileged `monitor` user by default. To get the same root + kill capability the old image provided, opt in at `docker run` time:

```bash
# Before
docker run -d --pid=host --privileged -p 127.0.0.1:7681:7681 btleffler/ttyd-btop-privileged

# After (root inside the container — equivalent for monitoring + signaling)
docker run -d --pid=host --user root -p 127.0.0.1:7681:7681 btleffler/ttyd-tops:btop

# After (root + full --privileged — only if you need device/capability access)
docker run -d --pid=host --privileged --user root -p 127.0.0.1:7681:7681 btleffler/ttyd-tops:btop
```

For most monitoring use cases, `--user root` alone is enough — `--pid=host` makes container root act as host root for signal-permission purposes, which is what enabled `kill` from the web terminal in the old image. `--privileged` grants additional kernel/device access that was rarely needed.

For Compose, swap the `image:` line and replace `privileged: true` with `user: "0:0"`:

```yaml
services:
  btop-monitor:
    image: btleffler/ttyd-tops:btop  # was: btleffler/ttyd-btop-privileged
    pid: host
    user: "0:0"                       # was: privileged: true
    ports:
      - "127.0.0.1:7681:7681"
    restart: unless-stopped
```

The new README documents three security tiers — see [github.com/btleffler/ttyd-tops](https://github.com/btleffler/ttyd-tops) for the full explanation.

## Why

Maintaining `ttyd-btop` and `ttyd-btop-privileged` as two near-duplicate repos was wasteful, and the project's scope was only ever going to grow as more TUI monitors became interesting. `ttyd-tops` consolidates both projects, expands the tool list, and lets users opt into kill capability at runtime instead of requiring a separate image.

## What about updates?

This image will not receive further updates. The `btleffler/ttyd-btop-privileged` Docker Hub tag remains pullable indefinitely, but you should migrate to `btleffler/ttyd-tops:btop` to stay current.

## Links

- New project: [github.com/btleffler/ttyd-tops](https://github.com/btleffler/ttyd-tops) · [hub.docker.com/r/btleffler/ttyd-tops](https://hub.docker.com/r/btleffler/ttyd-tops)
- Companion (also deprecated): [btleffler/ttyd-btop](https://github.com/btleffler/ttyd-btop) — replaced by `btleffler/ttyd-tops:btop` (drop-in, no flags needed).
