# Socks5 Reverse Proxy

## Build

```
docker build --rm --no-cache -t sock5-server --build-arg USERNAME=shenyu --build-arg PASSWD=123456 .
```

## Run

```bash
docker run --restart unless-stopped --name sock5-server -p 1080:1080 -d sock5-server
```
