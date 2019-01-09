```bash
# centos 6
pip3 install awscli --upgrade --user
echo "export PATH=~/.local/bin:$PATH" >> /etc/profile
aws --version
aws configure
```

```bash
# region name
https://docs.aws.amazon.com/general/latest/gr/rande.html
```

```bash
# availability-zone
ap-northeast-1a
# key-pair-name
id_rsa_2048
```

```bash
# usage

# get instance[0] name
aws lightsail get-instances | jq .instances[0].name | sed 's/"//g'

aws lightsail delete-instances --instance-name <value>

aws lightsail stop-instance --instance-name <value>
aws lightsail start-instance --instance-name <value>
aws lightsail restart-instance --instance-name <value>

aws lightsail create-instances --instance-names <value> --availability-zone <value> --key-pair-name <value> --blueprint-id Debian --bundle-id nano_2_0

aws lightsail create-instances-from-snapshot --instance-names <value> --availability-zone <value> --key-pair-name <value> --bundle-id nano_2_0 --instance-snapshot-name jp-snapshot


```
