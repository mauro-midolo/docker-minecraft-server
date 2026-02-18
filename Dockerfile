ARG ALPINE_VERSION=3.23.3
ARG MC_VERSION

############################
# STAGE 1 - Download jar
############################
FROM alpine:${ALPINE_VERSION} as download
ARG MC_VERSION

RUN apk add --no-cache curl jq

RUN test -n "${MC_VERSION}" \
 && VERSION_URL="$(curl -sSL https://launchermeta.mojang.com/mc/game/version_manifest.json \
      | jq -r --arg v "${MC_VERSION}" '.versions[] | select(.id==$v) | .url')" \
 && test -n "${VERSION_URL}" && test "${VERSION_URL}" != "null" \
 && SERVER_URL="$(curl -sSL "${VERSION_URL}" | jq -r '.downloads.server.url')" \
 && test -n "${SERVER_URL}" && test "${SERVER_URL}" != "null" \
 && curl -fSL "${SERVER_URL}" -o /server.jar

############################
# STAGE 2 - Runtime
############################
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache openjdk21-jre-headless

RUN adduser -D minecraft-user
USER minecraft-user
WORKDIR /home/minecraft-user

COPY --from=download /server.jar ./server.jar
COPY eula.txt ./eula.txt

EXPOSE 25565

ENTRYPOINT ["sh","-eu","-c", "\
SEED=''; \
ARGS=''; \
while [ \"$#\" -gt 0 ]; do \
  case \"$1\" in \
    --seed) \
      SEED=\"$2\"; shift 2 ;; \
    --seed=*) \
      SEED=\"${1#--seed=}\"; shift 1 ;; \
    *) \
      ARGS=\"$ARGS '$1'\"; shift 1 ;; \
  esac; \
done; \
if [ -n \"$SEED\" ]; then \
  [ -f server.properties ] || touch server.properties; \
  if grep -q '^level-seed=' server.properties; then \
    sed -i \"s/^level-seed=.*/level-seed=${SEED}/\" server.properties; \
  else \
    echo \"level-seed=${SEED}\" >> server.properties; \
  fi; \
fi; \
# shellcheck disable=SC2086 \
eval exec java -jar server.jar nogui $ARGS \
","--"]
CMD []
