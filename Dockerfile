FROM alpine:latest

# 安裝必要套件
RUN apk update && apk add --no-cache \
    openssh \
    openssh-server \
    openssh-client \
    mysql-client \
    mariadb-client

RUN ssh-keygen -A

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN echo "alias ll='ls -al'" >> /root/.profile

# 複製啟動腳本進容器並賦予執行權限
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22

# 改用 entrypoint 腳本啟動
ENTRYPOINT ["/entrypoint.sh"]
