ARG LIT_VERSION="latest"

FROM ghcr.io/my-luvit/lit:${LIT_VERSION}
ARG LIT_VERSION
ARG LIT_DIR=/var/lib/lit
ENV WEB_PREFIX="https://localhost" \
    LIT_CONFIG=/root/.litconfig

LABEL org.opencontainers.image.title="Lit Server" \
      org.opencontainers.image.description="Luvit invention toolkit upstream server" \
      org.opencontainers.image.version="${LIT_VERSION}" \
      org.opencontainers.image.source="https://github.com/my-luvit/lit" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.authors="Bilal Bassam" \
      org.opencontainers.image.vendor="Luvit.io"

VOLUME "${LIT_DIR}"
COPY ./.litconfig ${LIT_CONFIG}

COPY --from=my-luvit/lit:${LIT_VERSION} /usr/bin/lit /usr/bin/lit
EXPOSE 4822
# lit does not respond to graceful signals
STOPSIGNAL SIGKILL

HEALTHCHECK --interval=5m --timeout=30s --start-period=30s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider ${WEB_PREFIX} || exit 1

ENTRYPOINT /usr/bin/lit serve
CMD [ "${WEB_PREFIX}" ]
