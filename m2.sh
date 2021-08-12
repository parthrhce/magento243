#Require commands for magento2.4 

apt-get update
apt-get install lamp-server^ -y 
apt-get -y install php7.4-mysql php7.4-curl php7.4-gd php7.4-intl php-pear php-imagick php7.4-imap php-memcache  php7.4-pspell php7.4-sqlite3 php7.4-tidy php7.4-xmlrpc php7.4-xsl php7.4-mbstring php7.4-gettext php7.4-bcmath php7.4-soap php7.4-zip  php7.4-intl php7.4-soap php7.4-bcmath -y 
a2enmod ssl rewrite headers expires 
systemctl restart apache2
apt-get install phpmyadmin -y
apt update
apt install openjdk-8-jdk -y 
apt -y install gnupg
apt upgrade
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
apt -y install apt-transport-https
apt-get update && sudo apt-get install elasticsearch -y
update-rc.d elasticsearch defaults 95 10
service elasticsearch start
/bin/systemctl daemon-reload
/bin/systemctl enable elasticsearch.service
systemctl start elasticsearch.service
/bin/systemctl daemon-reload
/bin/systemctl enable elasticsearch.service
systemctl restart elasticsearch.service
apt install snapd -y
snap install core; sudo snap refresh core
snap install --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot
apt-get install composer -y
