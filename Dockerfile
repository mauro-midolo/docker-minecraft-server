FROM alpine:3.9.5 as download
RUN apk add wget
RUN wget https://piston-data.mojang.com/v1/objects/4707d00eb834b446575d89a61a11b5d548d8c001/server.jar --output-document=/server.jar

FROM alpine:3.9.5
RUN apk add openjdk8-jre
RUN adduser minecraft-user -D
USER minecraft-user
WORKDIR /home/minecraft-user

COPY --from=download /server.jar ./server.jar
COPY eula.txt ./eula.txt

EXPOSE 25565

CMD ["java" ,"-jar", "server.jar", "nogui"]
