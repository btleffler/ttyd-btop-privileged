FROM alpine:latest

RUN apk add --no-cache ttyd btop

EXPOSE 7681

CMD ["ttyd", "-W", \
     "-t", "titleFixed=btop (privileged) — host monitor", \
     "sh", "-c", "while true; do btop; done"]
