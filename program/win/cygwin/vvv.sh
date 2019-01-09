#!/usr/bin/bash

localPath(){
    explorer /e,$(cygpath.exe -aw ./)
}

openPath(){
    explorer /e,$(cygpath.exe -aw $1)
}

sublimeFile(){
    file_path=$(cygpath.exe -aw "$1")
    /cygdrive/d/'Program Files'/'Sublime Text 3'/sublime_text.exe "$file_path" &
}

createFile() {
    touch "$1"
}

createFolder() {
    mkdir "$1"
}

if [ -z $1 ];then
    # 空字符串，视之为当前路径
    echo "open local folder"
    localPath
elif [[ ${1:0:2} == "./" || ${1:0:1} == "/" || $1 == "." || $1 == ".." ]];then
    # ./ 或 / 开头，. 或 .. ，视之为路径
    echo "open folder: "$1
    openPath $1
elif [[ -d $1 ]];then
    echo "open folder: "$1
    openPath "./$1"
elif [[ -f $1 ]];then
    echo "Edit file: "$1
    sublimeFile $1
else
    read -p "[default] do nothing   [1] createFile  [2] createFolder   | " action
    case $action in
        1)
        createFile $1
        ;;
        2)
        createFolder $1
        ;;
        *)
        exit 1;
        ;;
    esac
fi
