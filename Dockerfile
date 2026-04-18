FROM alpine:latest

LABEL org.opencontainers.image.title="ttyd-btop-privileged" \
      org.opencontainers.image.description="Browser-based btop terminal for monitoring a Linux host (privileged, full root access)." \
      org.opencontainers.image.source="https://github.com/btleffler/ttyd-btop-privileged" \
      org.opencontainers.image.url="https://github.com/btleffler/ttyd-btop-privileged" \
      org.opencontainers.image.documentation="https://github.com/btleffler/ttyd-btop-privileged#readme" \
      org.opencontainers.image.authors="btleffler <btleffler@gmail.com>" \
      org.opencontainers.image.licenses="MIT"

RUN apk add --no-cache ttyd btop

ENV LANG=C.UTF-8

EXPOSE 7681

CMD ["ttyd", "-W", \
     "-t", "titleFixed=btop (privileged) — host monitor", \
     "sh", "-c", "while true; do btop; done"]
