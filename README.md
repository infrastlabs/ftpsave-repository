# ftpsave-repository

用shell简单组织的一个实用的工具，实现文件仓库的概念。 可用于应对不适合放git仓库的场景，用来放那些大的二进制文件。

## 一、功能

- 1.基于ftp/httpServer来存放文件、提供下载服务

- 2.gen.sh:  给FTP子目录(repos)生成一个txt列表，附带MD5码

- 3.down.sh：从ftp读取txt列表，依次下载文件(TODO MD5校验完整性)。文件可缓存于本地，有缓存时先依据MD5做校验，以判断FTP上文件是否有更新

## 二、FTP(docker-compose.yml)

- 设定实际IP

```yaml
    environment:
      #- PASV_ADDRESS="172.25.23.191"
      - PASV_ADDRESS="6.6.6.92"
```

- 顶层帐号

```yaml
    environment:
      - FTP_PASS="ftpsave"
      - FTP_USER="ftpsave"
```

- 添加子帐号(repository) 进入容器内操作

`addftpuser repo2 yourFtpPass`


## 三、HTTP

- 默认帐号 `root:root`
- 更改密码 `vi /etc/lighttpd/.lighttpd.user`
