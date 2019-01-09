```bash
keytool -genkeypair -alias testname -keystore /root/ssr.keystore -sigalg MD5withRSA -keyalg RSA ##ssr编译用时，最后一步密码留空即可
keytool -list -keystore /root/ssr.keystore
keytool -delete -keystore /root/ssr.keystore
```
