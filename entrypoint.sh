#!/bin/sh

# 如果有設定 SSH_PUBLIC_KEY 這個環境變數，就寫入 authorized_keys
if [ -n "$SSH_PUBLIC_KEY" ]; then
    mkdir -p /root/.ssh
    chmod 700 /root/.ssh
    echo "$SSH_PUBLIC_KEY" > /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    echo "SSH Public Key injected successfully."
else
    echo "WARNING: SSH_PUBLIC_KEY environment variable is missing."
fi

# 執行原本 Docker 要執行的 SSHD 常駐指令
exec /usr/sbin/sshd -D
