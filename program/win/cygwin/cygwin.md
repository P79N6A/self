### uninstall
```
# delete these
HKEY_LOCAL_MACHINE\SOFTWARE\Cygwin
HKEY_CURRENT_USER\Software\Cygwin
HKEY_CURRENT_USER\Software\Classes\VirtualStore\MACHINE\SOFTWARE\Wow6432Node\Cygwin
```


### command line setup.exe
```bash
setup-x86.exe --quiet-mode --upgrade-also --site="%MIRROR%" --no-admin --no-shortcuts --no-startmenu --no-desktop --root="%CYGWIN_HOME%"
```

### init
```bash
export PATH=$PATH:/usr/sbin
export LANG='en_US.UTF-8'
```
