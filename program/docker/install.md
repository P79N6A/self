### Debian 9
```bash
apt-get remove docker docker-engine docker.io -y
apt-get update -y && apt-get install wget curl vim git -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
#add-apt-repository \
#   "deb [arch=amd64] https://download.docker.com/linux/debian \
#   $(lsb_release -cs) \
#   stable"
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update -y
apt-get install docker-ce -y
```
