# ftpsave-repository

用shell简单组织的一个实用的工具，实现文件仓库的概念。 可用于应对不适合放git仓库的场景，用来放那些大的二进制文件。

## 一、功能

- 1.基于ftp/httpServer来存放文件、提供下载服务

- 2.gen.sh:  给FTP子目录(repos)生成一个txt列表，附带MD5码

- 3.down.sh：从ftp读取txt列表，依次下载文件(TODO MD5校验完整性)。文件可缓存于本地，有缓存时先依据MD5做校验，以判断FTP上文件是否有更新

## 二、快速开始

**0.设定实际IP(docker-compose.yml)**

```yaml
    environment:
      #- PASV_ADDRESS="172.25.23.191"
      - PASV_ADDRESS="6.6.6.92"
```

**1.默认帐号**

```yaml
ftp_ip: YourIP
ftp_port: 21
ftp_user_pass: ftpsave:ftpsave

http_ip: $ftp_ip #same
http_port: 80
http_digest_auth: root:root
```

**2.FTP上送文件，gen.sh生成摘要**

```bash
1).use ftp-client like filezilla to trans or manager the repos in ftp. #repository1 repository2
2).exec `gen.sh` in the vm/container to generate the `files-repository1.txt` #fileList with md5.
3).each time you changed the files, please exec `gen.sh`
4).the be a exclude params `exclude="_ex"`, which means if a pathfile like `repository1/aa1/_ex/file1.txt` with not generate to the md5 file.
```

**3.下载示例**

```bash
export AUTH=root:root
url=http://6.6.6.92/
file=down1.sh

#headInfo just pre-seted in down1.sh (down-xx.sh to each repo)
curl -u $AUTH -s $url/$file > $file && bash $file #use bash
```

## 三、配置项

### 1.FTP

- 顶层帐号(docker-compose.yml)

```yaml
    environment:
      - FTP_PASS="ftpsave"
      - FTP_USER="ftpsave"
```

- 添加子帐号(repository) 进入容器内操作

`addftpuser repo2 yourFtpPass`


### 2.HTTP

- 默认帐号 `root:root`
- 更改密码 `vi /etc/lighttpd/.lighttpd.user`

[README_en](README_en.md)
