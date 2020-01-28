FROM alpine:3.9.5 as download
RUN apk add wget
RUN wget https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar --output-document=/server.jar

FROM alpine:3.9.5
RUN apk add openjdk8-jre
USER minecraft-user
COPY --from=download /server.jar ./server.jar
CMD ["java" ,"-jar", "server.jar", "nogui"]
