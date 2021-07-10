 
# update and unzip
apt-get -y update && apt-get install -y unzip
 
# install consul 
cd /home/ubuntu
version='1.8.0'
wget https://releases.hashicorp.com/consul/${version}/consul_${version}_linux_amd64.zip -O consul.zip
unzip consul.zip
rm consul.zip
 
# make consul executable
chmod +x consul
mv consul /usr/local/bin/

