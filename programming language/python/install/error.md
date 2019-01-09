centos 6.x pip通过 get-pip.py 更新后出现的bug
```
{str(c.version) for c in all_candidates},
                      ^
SyntaxError: invalid syntax
```

```
yum remove python-pip -y
```
