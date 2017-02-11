sudo apt install -y python3-pip
sudo apt install -y npm
sudo apt install -y git
sudo ln -s /usr/bin/nodejs /usr/bin/node

pip3 install --upgrade pip
sudo pip3 install Django==1.10.5
sudo pip3 install django-crontab
sudo pip3 install django-jenkins

sudo npm install -g phantomjs-prebuilt 
sudo npm install -g casperjs # Might need to do in own directory?
sudo pip3 install django-casper
sudo sed -i 's/django.test/django.contrib.staticfiles.testing/g' /usr/local/lib/python3.5/dist-packages/casper/tests.py
sudo sed -i 's/LiveServerTestCase/StaticLiveServerTestCase/g' /usr/local/lib/python3.5/dist-packages/casper/tests.py

sudo apt-get install sqlite3 libsqlite3-dev

sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install -y openjdk-7-jdk

: <<'SKIP_JENKINS'

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo 'deb https://pkg.jenkins.io/debian-stable binary/' | tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y jenkins
sudo systemctl start jenkins

# Not sure the apache stuff needs to be done...

sudo apt-get install -y apache2
sudo a2enmod proxy
sudo a2enmod proxy_http
echo "<Virtualhost *:80>
    ServerName        my.jenkins.id
    ProxyRequests     Off
    ProxyPreserveHost On
    AllowEncodedSlashes NoDecode
 
    <Proxy http://localhost:8080/*>
      Order deny,allow
      Allow from all
    </Proxy>
 
    ProxyPass         /  http://localhost:8080/ nocanon
    ProxyPassReverse  /  http://localhost:8080/
    ProxyPassReverse  /  http://my.jenkins.id/
</Virtualhost>" | sudo tee /etc/apache2/sites-available/jenkins.conf

sudo a2ensite jenkins
sudo systemctl restart apache2
sudo systemctl restart jenkins

# Jenkins still needs to be configured.
# Follow instructions from https://www.howtoforge.com/tutorial/how-to-install-jenkins-with-apache-on-ubuntu-16-04/#step-configure-jenkins

SKIP_JENKINS

git clone https://github.com/Numorphan/INTELL_Game.git
cp INTELL_Game/cs499-intell-1.0.tar.gz ./
tar -xvf cs499-intell-1.0.tar.gz
python3 cs499-intell-1.0/manage.py migrate



