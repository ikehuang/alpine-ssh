FROM alpine:latest

# 1. 一次性安裝所有需要的套件，並建立 sshd 運行所需的目錄
RUN apk update && apk add --no-cache \
    openssh \
    openssh-server \
    openssh-client \
    mysql-client

# 2. 生成 SSH 密鑰
RUN ssh-keygen -A

# 3. 設置 root 密碼
RUN echo "root:Kp70aJXWLxQAgmzh9NDojFy1432Y5u68" | chpasswd

# 4. 允許 root 登錄與密碼認證
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# 5. 暴露 SSH 端口
EXPOSE 22

# 6. 【關鍵修正】同時啟動 sshd 並保持前台運行
# 利用 /usr/sbin/sshd -D 讓 SSH 服務常駐在前台，容器就不會退出，也不需要額外的 while true sleep 指令
CMD ["/usr/sbin/sshd", "-D"]
