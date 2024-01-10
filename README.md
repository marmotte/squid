squid
====
squid proxyサーバのDocker化サンプル

## ビルド
```
$ docker build . -t marmotte/squid
```

## 実行
```
$ docker run -it --rm -p 3128:3128 marmotte/squid
$ docker run -it --rm -p 3128:3128 -v ./squid.conf:/etc/squid/squid.conf marmotte/squid
```

