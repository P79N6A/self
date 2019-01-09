#### 重命名
```bash
for file in `ls`; do n=$(echo $file | sed 's/全部便签//g') && mv $file $n; done
```

#### cat 查看是否为unix/dos模式
```bash
cat --show-nonprinting $file
```

#### awk杀进程
```bash
ps | grep fpm | awk '{print $1}' | xargs kill -9
```

#### 统计出现次数
```bash
cat dns.log | awk '{print $5}' | sed 's/,//g' | sort | uniq -c | sort -n
```

#### 不包含
```bash
# \ 需要转义
tail -f dns.log | grep -v 'google\|gvt'
```
