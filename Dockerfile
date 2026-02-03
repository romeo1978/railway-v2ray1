FROM alpine:latest

RUN apk add --no-cache curl unzip

RUN mkdir -p /usr/local/bin/xray
WORKDIR /usr/local/bin/xray

RUN curl -L -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    && unzip xray.zip \
    && rm xray.zip \
    && chmod +x xray

COPY config.json /etc/xray/config.json

EXPOSE 80 443

# ✅ This is where the xray binary is
CMD ["/usr/local/bin/xray/xray", "-config", "/etc/xray/config.json"]
