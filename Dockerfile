FROM alpine:3.9.5 as download
RUN apk add wget
RUN wget https://piston-data.mojang.com/v1/objects/64bb6d763bed0a9f1d632ec347938594144943ed/server.jar --output-document=/server.jar

FROM alpine:3.9.5
RUN apk add openjdk8-jre
RUN adduser minecraft-user -D
USER minecraft-user
WORKDIR /home/minecraft-user

COPY --from=download /server.jar ./server.jar
COPY eula.txt ./eula.txt

EXPOSE 25565

CMD ["java" ,"-jar", "server.jar", "nogui"]
