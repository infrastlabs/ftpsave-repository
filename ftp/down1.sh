#!/bin/bash

repofile="files-repository1.txt"
repourl="http://6.6.6.92"
savepath="/opt/ftp_down" #down>edit, if you need change your savepath before you exec this scripts.

#get files-repository1.txt
export AUTH=root:root
mkdir -p $savepath && cd $savepath
curl -u $AUTH -s $repourl/$repofile > $repofile


#loop judge: localCached/wget
function eachJudgeDown(){
    #cat $repofile
    IFS_old=$IFS
    IFS=$'\n'
    for one in `cat $repofile`
    do
        file=`echo $one |cut -d'|' -f2`
        md5A=`echo $one |cut -d'|' -f1`

        #each file: new-down or exist.
        if [ -f "$file" ]; then
		    md5B=`md5sum $file |awk '{print $1}'`
            md5B=${md5B:0:8}

            echo "[md5Compare: "$md5A"~"$md5B"]"
            if [ ! "$md5A" = "$md5B" ]; then #judgeMD5
                echo "Md5 unmatch(last down broken, or ftp refreshed), re-download file: "$file ## del, reDownload
                #rm -f $file #danger! #nodel just ">" reWrite file.
                curl -u $AUTH -s $repourl/$file > $file #dir exist already.
            fi
        else #file not exist
            mkdir -p ${file%/*} #mkdir
            echo "new download file: "$file
            curl -u $AUTH -s $repourl/$file > $file

            #TODO1 validate MD5
		fi
    done
    IFS=$IFS_old
}

#bigfile: md5>cr32>>sha256
#TODO2 when each downloaded, just save the local-Md5 to a list, to save the time-cost of m5dsum

eachJudgeDown
tree -ah $savepath #view

