# The official XTLS image is distroless-style (no shell), so take only its
# binary + geodata and run them on debian-slim, which provides /bin/sh + sed
# for the entrypoint's env substitution.
FROM ghcr.io/xtls/xray-core:v26.10.21 AS xray-src
FROM debian:13-slim
COPY --from=xray-src /usr/local/bin/xray /usr/local/bin/xray
COPY --from=xray-src /usr/local/share/xray/ /usr/local/share/xray/
COPY config.template.json /usr/local/etc/xray/config.template.json
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
