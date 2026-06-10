FROM alpine:latest
RUN apk update && apk add --no-cache mysql-client mariadb-client
CMD ["sh", "-c", "while true; do sleep 3600; done"]
