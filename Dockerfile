FROM       alpine:3.17
MAINTAINER Yosuke Yamamoto "marmotte.se30@gmail.com"

ENV TZ=Asia/Tokyo

RUN apk update && \
    apk add tzdata && \
    apk add squid && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    rm -Rf /var/cache/apk/*

ARG SQUID_CONF=/etc/squid/squid.conf

RUN grep -E ^pid_filename ${SQUID_CONF} || \
    echo "pid_filename none" >> ${SQUID_CONF}
RUN grep -E ^logfile_rotate ${SQUID_CONF} || \
    echo "logfile_rotate 0" >> ${SQUID_CONF}
RUN grep -E ^access_log ${SQUID_CONF} || \
    echo "access_log stdio:/proc/self/fd/1" >> ${SQUID_CONF}

VOLUME /etc/squid/
EXPOSE 3128

USER squid
CMD ["/usr/sbin/squid", "-NYCd", "0"]

