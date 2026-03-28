FROM alpine
RUN apk --no-cache add libgcc

ENV WEB_PREFIX="https://localhost"
ENV LIT_CONFIG=/root/.litconfig
ARG LIT_VERSION="latest"
ARG LIT_DIR=/var/lib/lit

LABEL org.opencontainers.image.title="Lit Server"
LABEL org.opencontainers.image.description="Luvit invention toolkit upstream server"
LABEL org.opencontainers.image.version="${LIT_VERSION}"
LABEL org.opencontainers.image.source="https://github.com/my-luvit/lit"
# LABEL org.opencontainers.image.revision= Inapplicable here
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.authors="Bilal Bassam"
LABEL org.opencontainers.image.vendor="Luvit.io"
LABEL org.opencontainers.image.base.name="alpine:latest"

VOLUME "${LIT_DIR}"

COPY --from=my-luvit/lit:${LIT_VERSION} /usr/bin/lit /usr/bin/lit
COPY ./.litconfig ${LIT_CONFIG}

EXPOSE 4822
HEALTHCHECK --interval=5m --timeout=30s --start-period=30s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1
# lit does not respond to graceful signals
STOPSIGNAL SIGKILL

LABEL key="value"

ENTRYPOINT /usr/bin/lit serve ${WEB_PREFIX}
