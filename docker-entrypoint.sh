#!/bin/bash

if [ "$1" = "start" ]; then
    if [ ! -f /etc/3proxy.cfg ]; then
        if [ -z "$PROXY_LOGIN" ] || [ -z "$PROXY_PASSWORD" ]; then
            echo >&2 'error: proxy is uninitialized, variables is not specified '
            echo >&2 '  You need to specify PROXY_LOGIN and PROXY_PASSWORD'
            exit 1
        fi

        _term() {
            echo "Caught SIGTERM signal!"
            kill -TERM "$child" 2>/dev/null
        }

        trap _term SIGTERM

        echo "writable" > /etc/3proxy.cfg
        echo "nserver 1.1.1.1" >> /etc/3proxy.cfg
        echo "nserver 8.8.8.8" >> /etc/3proxy.cfg
        echo "nserver 8.8.4.4" >> /etc/3proxy.cfg
        echo "nscache 65536" >> /etc/3proxy.cfg
        echo "nsrecord www.porno.com 127.0.0.1" >> /etc/3proxy.cfg
        echo "" >> /etc/3proxy.cfg
        echo 'counter "/etc/3proxy/cfg/3proxy.3cf" D "/etc/3proxy/cfg/traf"' >> /etc/3proxy.cfg
        echo "log" >> /etc/3proxy.cfg
        echo 'logformat "L%t%. L%t.%. %N.%p %E %U %C:%c %R:%r %O %I %h %T"' >> /etc/3proxy.cfg
        echo "" >> /etc/3proxy.cfg
        echo "monitor /etc/3proxy.cfg" >> /etc/3proxy.cfg
        echo "" >> /etc/3proxy.cfg
        echo "users $PROXY_LOGIN:CL:$PROXY_PASSWORD" >> /etc/3proxy.cfg
        echo "" >> /etc/3proxy.cfg
        echo "auth strong" >> /etc/3proxy.cfg
        echo "proxy -p3128" >> /etc/3proxy.cfg
        echo "socks -p1080" >> /etc/3proxy.cfg
        echo "admin -p8080" >> /etc/3proxy.cfg
        echo "" >> /etc/3proxy.cfg
        echo "flush" >> /etc/3proxy.cfg

        echo "Proxy user login:    $PROXY_LOGIN"
        echo "Proxy user password: $PROXY_PASSWORD"
        echo "Proxy process started!"
    fi

    /etc/3proxy/3proxy /etc/3proxy.cfg &

    child=$!
    wait "$child"

else
    exec "$@"
fi
