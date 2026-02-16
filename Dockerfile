# syntax=docker/dockerfile:1

ARG ALPINE_VERSION=3.23.3
ARG MC_VERSION

FROM alpine:${ALPINE_VERSION} as download
ARG MC_VERSION

RUN apk add --no-cache curl jq

# 1) Trova l'URL del JSON della versione (es. 1.20.5)
# 2) Da lì ricava downloads.server.url
# 3) Scarica server.jar
RUN test -n "${MC_VERSION}" \
 && VERSION_URL="$(curl -sSL https://launchermeta.mojang.com/mc/game/version_manifest.json \
      | jq -r --arg v "${MC_VERSION}" '.versions[] | select(.id==$v) | .url')" \
 && test -n "${VERSION_URL}" && test "${VERSION_URL}" != "null" \
 && SERVER_URL="$(curl -sSL "${VERSION_URL}" | jq -r '.downloads.server.url')" \
 && test -n "${SERVER_URL}" && test "${SERVER_URL}" != "null" \
 && curl -fSL "${SERVER_URL}" -o /server.jar

FROM alpine:${ALPINE_VERSION}
# Per MC >= 1.20.5 usa Java 21 (altrimenti cambia pacchetto o usa un'immagine Temurin)
RUN apk add --no-cache openjdk21-jre-headless

RUN adduser -D minecraft-user
USER minecraft-user
WORKDIR /home/minecraft-user

COPY --from=download /server.jar ./server.jar
COPY eula.txt ./eula.txt

EXPOSE 25565
CMD ["java","-jar","server.jar","nogui"]
