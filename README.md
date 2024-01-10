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

## squid.confの内容について
squid.confは `apk add squid` でインストールされるデフォルトをそのまま流用。  
ただし、以下のディレクティブを明示的に追加しログを `docker log` に出力するよう調整済み

### 追加設定項目
```agsl
pid_filename none
logfile_rotate 0
access_log stdio:/proc/self/fd/1

cache_mem 0 MB
cache_store_log none
```


|     ディレクティブ      | 設定値                 | 備考                                           |
|:----------------:|:----------------------|:---------------------------------------------|
|   pid_filename   | none                  | PIDファイルを作成しない                                |
|  logfile_rotate  | 0                     | ログファイルを出力しないため、ログファイルローテートは必要なし |
|    access_log    | stdio:/proc/self/fd/1 | `/proc/self/fd/1` を指定し `docker log` に出力 　　　　 |
| cache_mem        | 0 MB                  | メモリキャッシュとして使用するメモリ                      |
| cache_store_log  | none                  | ストレージマネージャの活動ログ                           |
