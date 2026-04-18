# ttyd-btop-privileged

Browser-based btop terminal for monitoring a Linux host — with **full root access**.

> **⚠️ Security Warning:** This image runs as root with `--privileged`. It can see _and kill_ any process on the host. **Only use on trusted, private networks.** If you don't need root access, use the unprivileged image instead: [btleffler/ttyd-btop](https://hub.docker.com/r/btleffler/ttyd-btop)

## Quick Start

```bash
docker run -d --name btop-monitor \
  --pid=host --privileged \
  -p 127.0.0.1:7681:7681 \
  --restart unless-stopped \
  btleffler/ttyd-btop-privileged
```

Then open [http://localhost:7681](http://localhost:7681) in your browser.

## Docker Compose

```yaml
services:
  btop-monitor-privileged:
    image: btleffler/ttyd-btop-privileged
    pid: host
    privileged: true
    ports:
      - "127.0.0.1:7681:7681"
    restart: unless-stopped
```

## How It Works

- **ttyd** serves a web-based terminal on port 7681 (xterm.js in the browser).
- **btop** runs in a loop (`while true; do btop; done`) so it restarts immediately if exited. There is no way to break out to a shell.
- `--pid=host` gives the container visibility into all host processes.
- `--privileged` grants full root capabilities, including the ability to send signals (kill) to host processes.

## Port Binding

The default compose file binds to `127.0.0.1:7681`, meaning it's only accessible from the host itself. To expose it on the network, change to `0.0.0.0:7681:7681` — but strongly consider putting a reverse proxy with authentication in front of it.

## Built For

Raspberry Pi 3B (ARMv7) and other ARM/x86 Linux hosts. Alpine has full multi-arch support.

## See Also

- [btleffler/ttyd-btop](https://hub.docker.com/r/btleffler/ttyd-btop) — Unprivileged version (read-only monitoring, cannot kill host processes)
