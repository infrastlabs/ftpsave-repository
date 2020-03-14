#!/bin/bash
exclude="_ex"

function genOne (){
    repo=$1
    t1=/tmp/repo-lst.txt
    
    # find.exclude -> each: md5{8}|pathfile
    find $repo -type f |grep -v $exclude > $t1
    dest="files-"$repo".txt"
    : > $dest #clean

    #md5|pathfile
    IFS_old=$IFS
    IFS=$'\n'
    for one in `cat $t1`
    do
      md5=`md5sum $one |awk '{print $1}'`
      md5=${md5:0:8}
      echo $md5"|"$one >> $dest
    done
    IFS=$IFS_old
}

#just one gen.sh gens all repos.
genOne "repository1" 




