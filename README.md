# ftpsave-repository

**1.ftp/http server**

```yaml
ftp_ip: YourIP
ftp_port: 21
ftp_user_pass: ftpsave:ftpsave

ftp_ip: $ftp_ip #same
http_port: 80
http_digest_auth: root:root
```

**2.uploadfiles/gen.sh**

```bash
1).use ftp-client like filezilla to trans or manager the repos in ftp. #repository1 repository2
2).exec `gen.sh` in the vm/container to generate the `files-repository1.txt` #fileList with md5.
3).each time you changed the files, please exec `gen.sh`
4).the be a exclude params `exclude="_ex"`, which means if a pathfile like `repository1/aa1/_ex/file1.txt` with not generate to the md5 file.
```

**3.repo download**

```bash
export AUTH=root:root
url=http://6.6.6.92/
file=down1.sh

#headInfo just pre-seted in down1.sh (down-xx.sh to each repo)
curl -u $AUTH -s $url/$file > $file && bash $file #use bash
```
