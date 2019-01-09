### /usr/bin/vimm sublime启动
```bash
cat > /usr/bin/vimm << 'EOF'
#!/bin/bash
file_path=`cygpath.exe -aw "$1"`
/cygdrive/d/'Program Files'/'Sublime Text 3'/sublime_text.exe $file_path &
EOF
chmod +x /usr/bin/vimm
```
### /usr/bin/winf 打开当前文件夹
```bash
cat > /usr/bin/winf << 'EOF'
#!/usr/bin/bash
explorer /e,$(cygpath.exe -aw ./$1)
EOF
```

### proxy
```bash
cat >> ~/.babunrc << 'EOF'
export http_proxy=http://127.0.0.1:8888
export https_proxy=$http_proxy
EOF
```

### git config
```bash
cat >> ~/.gitconfig << 'EOF'
[http]
    proxy = socks5://127.0.0.1:8888
[https]
    proxy = socks5://127.0.0.1:8888
[user]
    email = xxx@gmail.com
    name = xxx
EOF
```

### .ssh
```bash
mkdir ~/.ssh
cat >> ~/.ssh/config << 'EOF'
Host vs-ssh.visualstudio.com
        IdentityFile ~/.ssh/putty_key
EOF
chmod 600 ~/.ssh/config
chmod 600 ~/.ssh/putty_key

```

### path
```bash
vim ~/.zshrc
# path 增加 /usr/sbin, php-fpm、nginx都在这里
```
