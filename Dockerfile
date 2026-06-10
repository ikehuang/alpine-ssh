FROM alpine:latest

# 安裝 OpenSSH 和其他必要工具
RUN apk add --no-cache openssh openssh-server openssh-client

# 生成 SSH 密鑰
RUN ssh-keygen -A

# 設置 root 密碼（使用你的密碼）
RUN echo "root:Kp70aJXWLxQAgmzh9NDojFy1432Y5u68" | chpasswd

# 允許 root 登錄
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# 暴露 SSH 端口
EXPOSE 22

# 啟動 SSH 服務
CMD ["/usr/sbin/sshd", "-D"]


RUN apk update && apk add --no-cache mysql-client

CMD ["sh", "-c", "while true; do sleep 3600; done"]
