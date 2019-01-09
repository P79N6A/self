# There are unfinished transactions remaining. You might consider running yum-complete-transaction first to finish them

```bash
yum install yum-utils -y
yum-complete-transaction --cleanup-only
```


# defunct process
```bash
ps -ef | grep defunct
```
