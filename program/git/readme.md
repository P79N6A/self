### proxy
```bash
git config --global http.proxy 'socks5://127.0.0.1:1080'
git config --global https.proxy 'socks5://127.0.0.1:1080'

# unset proxy
git config --global --unset http.proxy
git config --global --unset https.proxy
```

### 删除最近的历史commit
```bash
git reset --hard <commit id>
git push origin HEAD --force
```

### 刚git commit，未提交，撤销commit
```bash
git reset --soft HEAD^
```

### 删除分支
```bash
# 远程
git push --delete origin oldName

# 本地
git branch -D oldName
```

### 分支重命名
```bash
# 本地
git branch -m oldName newName
```
