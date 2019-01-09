apt-get remove docker docker-engine docker.io -y
apt-get update -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
#add-apt-repository \
#   "deb [arch=amd64] https://download.docker.com/linux/debian \
#   $(lsb_release -cs) \
#   stable"
apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update -y
apt-get install docker-ce wget curl vim git nload iftop -y
