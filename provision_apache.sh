#install apache
apt-get update
apt-get install -y apache2
#set Apache listen on port 8080
cp /vagrant/ports.conf /etc/apache2/.
cp /vagrant/000-default.conf /etc/apache2/sites-enabled/000-default.conf

#change the default page of Apache
cp /vagrant/index.html /var/www/html/index.html

#restart Apache
systemctl restart apache2
