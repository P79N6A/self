 for file in `ls`; do str=$(cat $file | awk -F '[n][a][m][e]|[.][p][n][g]' '{print $2}' | sed "s/=\|\\\u003d//g") && mv $file $str.json ; done
