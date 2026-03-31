FROM alpine AS builder

# TODO: add back the from-source builder

# Required arguments!
ARG LIT_VERSION
ARG LUVI_VERSION
ARG LUVIT_VERSION

ARG LUVI_OS="linux"
ARG LUVI_ARCH="x86_64"
ARG LUVI_ENGINE="luajit"
ARG LUVI_FLAVOR="regular-musl"

WORKDIR /build/bin
RUN apk add --no-cache curl libgcc && \
  curl -L https://raw.githubusercontent.com/my-luvit/lit/refs/heads/master/get-lit.sh | sh
# COPY ./luvi ./lit ./luvit /build/bin/

FROM scratch AS base
LABEL kind="prebuild"
LABEL arch=${LUVI_OS}
LABEL os=${LUVI_OS}
LABEL engine=${LUVI_ENGINE}

FROM base AS lit
COPY --from=builder --chmod=0755 /build/bin/lit /usr/bin/
LABEL version=${LIT_VERSION}

FROM base AS luvi
COPY --from=builder --chmod=0755 /build/bin/luvi /usr/bin/
LABEL version=${LUVI_VERSION}

FROM base AS luvit
COPY --from=builder --chmod=0755 /build/bin/luvit /usr/bin/
LABEL version=${LUVIT_VERSION}

FROM base AS all
COPY --from=builder --chmod=0755 /build/bin/* /usr/bin/
LABEL version=${LUVIT_VERSION}
LABEL luvit_version=${LUVIT_VERSION}
LABEL lit_version=${LIT_VERSION}
LABEL luvi_version=${LUVI_VERSION}
