#/bin/bash
domainname=magento243.cloudmania.co.in
mysqluser=magento243
mysqlpass=yR8yO3lI6xW8lO1q
adminpass=parth123

/usr/bin/sudo mkdir /home/$domainname

cd /home/$domainname
git clone https://github.com/parthrhce/magento243.git .
/usr/bin/sudo /usr/sbin/useradd -d '/home/'$domainname'' $domainname
/usr/bin/sudo /bin/cp -r '/home/'$domainname'/'apache2.conf  /etc/apache2/sites-available/$domainname.conf
/usr/bin/sudo /usr/bin/find /etc/apache2/sites-available/$domainname.conf -type f -exec sed -i 's/sample/'$domainname'/g' {} \;
ln -s /etc/apache2/sites-available/$domainname.conf /etc/apache2/sites-enabled/$domainname.conf
systemctl restart apache2
/usr/bin/sudo /usr/bin/certbot  --agree-tos --no-eff-email --email  info@$domainname  --apache -d  $domainname  --no-redirect --renew-by-default
/usr/bin/sudo /usr/bin/certbot  --agree-tos --no-eff-email --email  info@$domainname  --apache -d  www.$domainname  --no-redirect --renew-by-default
systemctl restart apache2
/usr/bin/mysql -uroot -p1 << EOF
CREATE DATABASE $mysqluser;
CREATE USER '$mysqluser'@'localhost' IDENTIFIED BY '$mysqlpass';
GRANT ALL PRIVILEGES ON $mysqluser .* TO '$mysqluser'@'localhost';
EOF


cd /home/$domainname

chmod 777 bin/magento

bin/magento setup:install --base-url=https://$domainname --db-host=localhost --db-name=$mysqluser --db-user=$mysqluser --db-password=$mysqlpass --admin-firstname=admin --admin-lastname=c --admin-email=info@$domainname --admin-user=admin --admin-password=$adminpass --language=en_US --currency=USD --timezone=America/Chicago --use-rewrites=1 --search-engine=elasticsearch7 --elasticsearch-host=localhost --elasticsearch-port=9200

bin/magento module:disable Magento_TwoFactorAuth

bin/magento setup:di:compile


chmod -R 777 var vendor generated pub/static  
