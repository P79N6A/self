```bash
# error    : Error: couldn’t get currently installed version for /opt/eff.org/certbot/venv/bin/letsencrypt
# reference: https://github.com/certbot/certbot/issues/1680#issuecomment-358728515
rm -rf /opt/eff.org/*
pip install -U certbot
# certbot renew --debug
# certbot certonly --standalone --email t@gmail.com -d t.org
```

```bash
openssl x509 -in cert.pem -noout -enddate
```
