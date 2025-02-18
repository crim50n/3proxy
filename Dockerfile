# 3proxy docker

FROM alpine:3.12 as builder

ARG VERSION=0.9.4

RUN apk add --update alpine-sdk linux-headers wget bash && \
    cd / && \
    wget -q  https://github.com/z3APA3A/3proxy/archive/${VERSION}.tar.gz && \
    tar -xf ${VERSION}.tar.gz && \
    cd 3proxy-${VERSION} && \
    make -f Makefile.Linux

# STEP 2 build a small image
FROM alpine:3.12

MAINTAINER Riftbit ErgoZ <ergozru@riftbit.com>

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION=0.9.4

LABEL org.label-schema.build-date=$BUILD_DATE \
	org.label-schema.name="3proxy Socks5 Proxy Container" \
	org.label-schema.description="3proxy Socks5 Proxy Container" \
	org.label-schema.vcs-ref=$VCS_REF \
	org.label-schema.vcs-url="https://github.com/crim50n/3proxy" \
	org.label-schema.version=$VERSION \
	org.label-schema.schema-version="1.0" \
	maintainer="crims0n"

COPY --from=builder /3proxy-${VERSION}/bin/3proxy /usr/local/bin/
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apk update && \
    apk upgrade && \
    apk add bash && \
    mkdir -p /etc/3proxy/traf &&\
    chmod +x /docker-entrypoint.sh && \
    chmod -R +x /usr/local/bin/3proxy

ENTRYPOINT ["/docker-entrypoint.sh"]

VOLUME ["/etc/3proxy"]

EXPOSE 3128:3128/tcp 1080:1080/tcp 8080:8080/tcp

CMD ["start"]
