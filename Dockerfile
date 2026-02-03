FROM alpine:latest

RUN apk add --no-cache curl unzip

# 创建工作目录
WORKDIR /tmp

# 下载并解压到临时目录
RUN curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    && unzip xray.zip \
    && mkdir -p /usr/local/bin/xray \
    && mv xray /usr/local/bin/xray/ \
    && mv geoip.dat geosite.dat /usr/local/bin/xray/ 2>/dev/null || true \
    && rm -f xray.zip \
    && chmod +x /usr/local/bin/xray/xray

# 复制配置文件
COPY config.json /etc/xray/config.json

# 确保配置文件可读
RUN chmod 644 /etc/xray/config.json

EXPOSE 80 443

# 使用绝对路径执行，并确保有执行权限
ENTRYPOINT ["/usr/local/bin/xray/xray"]
CMD ["-config", "/etc/xray/config.json"]
