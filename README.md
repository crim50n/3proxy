# What is Docker 3Proxy
Docker 3Proxy is a container with socks5 proxy server based on [3proxy](http://www.3proxy.ru/).

[![](https://images.microbadger.com/badges/version/crims0n/3proxy.svg)](https://microbadger.com/images/crims0n/3proxy) [![](https://images.microbadger.com/badges/image/crims0n/3proxy.svg)](https://microbadger.com/images/crims0n/3proxy) [![Docker Pulls](https://img.shields.io/docker/pulls/crims0n/3proxy.svg)](https://hub.docker.com/r/crims0n/3proxy/) [![Docker Stars](https://img.shields.io/docker/stars/crims0n/3proxy.svg)](https://hub.docker.com/r/crims0n/3proxy/) [![GitHub last commit](https://img.shields.io/github/last-commit/crim50n/3proxy.svg)](https://github.com/crim50n/3proxy) [![Build Status](https://travis-ci.org/crim50n/3proxy.svg?branch=master)](https://travis-ci.org/crim50n/3proxy)
  
Link on docker hub: [crims0n/3proxy](https://hub.docker.com/r/crims0n/3proxy/)

Link on github: [crim50n/3proxy](https://github.com/crim50n/3proxy)

### Build Args

 - PROXY_VERSION=0.9.4
 
 
### Environment variables:
 
 - PROXY_LOGIN - login for proxy user (:exclamation:required if config not exists!)
 - PROXY_PASSWORD - password for proxy user (:exclamation:required if config not exists!)

### Exposed Ports

 - **3128:3128/tcp** for http
 - **1080:1080/tcp** for socks5
 - **8080/tcp** for admin panel with cfg editor

### Volumes
 - /etc/3proxy/cfg

### Container Changelog (dd.mm.yyyy)

- **19.08.2021** - 3proxy updated to 0.9.4
- **15.01.2020** - 3proxy updated to 0.8.13
- **18.09.2019** - add admin panel, cfg volume, stdout logging
- **11.05.2018** - added http proxy and 3proxy updated to 0.8.12
- **12.01.2018** - readme cleanups. fixes and updates

### Example usage

```
docker run --name 3proxy -d -p 3128:3128 --env PROXY_LOGIN=pr0xyUser --env PROXY_PASSWORD=passw0rd crims0n/3proxy
```

After container starts you will see params for connection setup:

```
Proxy user login:         pr0xyUser
Proxy user password:      passw0rd
Proxy process pid:        6
Proxy process started!
```
