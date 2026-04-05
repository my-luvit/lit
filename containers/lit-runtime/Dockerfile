# Required arguments!
ARG LIT_VERSION
ARG LUVI_VERSION
ARG LUVIT_VERSION

ARG LUVI_OS="linux"
ARG LUVI_ARCH="x86_64"
ARG LUVI_ENGINE="luajit"
ARG LUVI_FLAVOR="regular"

FROM debian:stable-slim as base
ARG LIT_VERSION
ARG LUVI_VERSION
ARG LUVIT_VERSION
ARG LUVI_OS
ARG LUVI_ARCH
ARG LUVI_ENGINE
ARG LUVI_FLAVOR
ENV LIT_VERSION=${LIT_VERSION} \
    LUVI_VERSION=${LUVI_VERSION} \
    LUVIT_VERSION=${LUVIT_VERSION} \
    LUVI_OS=${LUVI_OS} \
    LUVI_ARCH=${LUVI_ARCH} \
    LUVI_ENGINE=${LUVI_ENGINE} \
    LUVI_FLAVOR=${LUVI_FLAVOR}
LABEL org.opencontainers.image.base.name="debian:stable-slim" \
      org.opencontainers.image.title="Luvit" \
      org.opencontainers.image.description="The luvit runtime combined with luvi and lit." \
      org.opencontainers.image.version="${LUVIT_VERSION}" \
      org.opencontainers.image.source="https://github.com/my-luvit/luvit" \
      org.opencontainers.image.licenses="MIT" \
      io.luvit.version=${LUVIT_VERSION} \
      io.luvit.kind="prebuild" \
      io.luvit.flavor=${LUVI_FLAVOR} \
      io.luvit.os=${LUVI_OS} \
      io.luvit.arch=${LUVI_ARCH} \
      io.luvit.engine=${LUVI_ENGINE}
# libgcc is required for all binaries 
RUN apt-get update && \
    apt-get install -y --no-install-recommends libgcc-s1 && \
    rm -rf /var/lib/apt/lists/*


FROM base AS builder
ARG LIT_VERSION
ARG LUVI_VERSION
ARG LUVIT_VERSION
ARG LUVI_OS
ARG LUVI_ARCH
ARG LUVI_ENGINE
ARG LUVI_FLAVOR
WORKDIR /build/bin
RUN apt-get update && \
    apt-get install -y libgcc-s1 git curl ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    curl -L https://raw.githubusercontent.com/my-luvit/lit/refs/heads/master/get-lit.sh | sh

FROM base AS lit
ARG LIT_VERSION
LABEL io.luvit.version=${LIT_VERSION}
COPY --from=builder /build/bin/lit /usr/bin/
ENTRYPOINT [ "/usr/bin/lit" ]
CMD [ "--version" ]

FROM lit AS lit-git
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git ca-certificates && \
    rm -rf /var/lib/apt/lists/*

FROM base AS luvi
ARG LUVI_VERSION
LABEL io.luvit.version=${LUVI_VERSION}
COPY --from=builder /build/bin/luvi /usr/bin/
ENTRYPOINT [ "/usr/bin/luvi" ]
CMD [ "--version" ]

FROM base AS luvit
ARG LUVIT_VERSION
COPY --from=builder /build/bin/luvit /usr/bin/
ENTRYPOINT [ "/usr/bin/luvit" ]
CMD [ "--version" ]

FROM base AS all
ARG LIT_VERSION
LABEL io.luvit.lit_version=${LIT_VERSION}
ARG LUVI_VERSION
LABEL io.luvit.luvi_version=${LUVI_VERSION}
ARG LUVIT_VERSION
LABEL io.luvit.luvit_version=${LUVIT_VERSION}
COPY --from=builder /build/bin/ /usr/bin/
ENTRYPOINT [ "/usr/bin/luvit" ]
CMD [ "--version" ]

FROM all AS all-git
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git ca-certificates && \
    rm -rf /var/lib/apt/lists/*
