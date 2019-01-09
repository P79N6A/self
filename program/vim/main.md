### setup /etc/vimrc
```
set autoindent
set smartindent
"set cindent
set expandtab
"set softtabstop=4
set tabstop=4
set cursorline
```

### 其他
```
# 撤销
u

# 从系统剪贴板粘贴到vim
"+p

# 从vim复制到系统剪贴板
"+y

# 选定内容,再复制到系统剪贴板,j可选
vj"+y

# vim内复制
v //选定内容
y //复制
```

### 批量注释
```bash
v
ctrl + v
# 上下移动选中所需
# insert，输入注释字符
Esc + Esc

```
