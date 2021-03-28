---
title: Things after install ubuntu 20.04 for developer
author: Leo
categories:
- Operation
- Ubuntu
tags:
- ubuntu
- ubuntu20.04
- setup
---

# First step
[Here is download file of the install scrip](https://raw.githubusercontent.com/zmerrychristmas/zmerrychristmas.github.io/master/download/install.sh)

*For a quick setup, I recommend that you create a file called  ``install.sh`` and run the following command every time you install:*
```zsh
chmod a+x ./install.sh
./install.sh
```
First  step we should update repository ubuntu:
```
sudo apt-get update
sudo apt-get upgrade -y
```
## Ubuntu packages for developer
```bash
sudo apt-get install build-essential -y
sudo apt-get install ubuntu-restricted-extras -y
```
## Add Ubuntu repository
```bash
sudo apt-add-repository universe #universe packages
sudo add-apt-repository ppa:ondrej/php #php ppa
sudo add-apt-repository ppa:gerardpuig/ppa # ubuntu cleaner
sudo add-apt-repository ppa:otto-kesselgulasch/gimp # gimp
sudo add-apt-repository ppa:openshot.developers/ppa # openshotqt
sudo add-apt-repository -y ppa:teejee2008/ppa #
```
## Ubuntu package and tools
```bash
sudo apt-get install build-essential -y
sudo apt-get install ubuntu-restricted-extras -y
sudo apt-get install gnome-tweak-tool -y
sudo apt-get install synaptic -y
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
sudo snap install vlc -y
sudo snap install skype -y
sudo apt-get install ubuntu-cleaner -y
sudo apt-get install simplescreenrecorder -y
sudo apt-get install gimp -y
sudo apt-get install cool-retro-term -y
sudo apt-get install openshot-qt -y
sudo apt-get install gnome-tweaks -y
sudo apt-get install chrome-gnome-shell -y
sudo apt-get install firefox-gnome-shell -y 
sudo apt-get install rar unrar p7zip-full p7zip-rar -y
sudo apt-get install timeshift -y
sudo apt-get install ibus-unikey -y
ibus restart
```
## Java install
```bash
sudo apt-get install openjdk-11-jdk -y
```
## LAMP install
```bash
sudo apt install apache2 -y
sudo ufw allow in "Apache"
sudo apt-get install -y mysql-server mysql-client libmysqlclient-dev libpq-dev
sudo apt install php libapache2-mod-php php-mysql -y
sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
```
### Install Composer and PHP7.4
```bash
curl -sS https://getcomposer.org/installer -o composer-setup.php
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo apt-get install -y zip unzip software-properties-common 
sudo apt-get install -y php7.4 php7.4-gd php7.4-mbstring php7.4-xml php-zip php7.4-mysql
```
### Git and Configure
```
sudo apt-get install git
git config --global color.ui true
git config --global user.name ""
git config --global user.email ""
ssh-keygen -t rsa -b 4096 -C ""
```
## Mysql
Configure mysql password
```bash
sudo mysql_secure_installation
```

## Ruby On Rails
```bash
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvms
ruby -v
gem install bundler
```
## Python
```bash
sudo apt-get install -y python2
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
sudo python2 get-pip.py
pip3 install scrapy
sudo apt-get install -y python3-pip
```
## Nodejs
```bash
sudo apt install npm -y
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
nvm list-remote
nvm install v14.0.0
nvm use v14.0.0
npm install --global yarn
```
## Docker
```bash
# Update ap-certificates
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo apt-get install -y py-pip python3-dev libffi-dev openssl-dev gcc libc-dev rust cargo make
sudo usermod -aG docker ${USER}
```
### Install Docker Compose
```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
source ~/.bashrc
```
### Docker Swamp
```bash
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt install docker-ce
```
**After install docker swarm, first step is configure node**
```bash
sudo vim /etc/hosts
```
Add following host
```vim
192.168.1.10	manager
192.168.1.11	worker-01
192.168.1.12	worker-02
```
**Create Docker Swarm Cluster**
```bash
sudo docker swarm init --advertise-addr 192.168.1.10

Swarm initialized: current node (fsuaqqpihi2eabmmq8gldzhpv) is now a manager. 
To add a worker to this swarm, run the following command: 
sudo docker swarm join --token SWMTKN-1-018kvdektwa74z8fajb5c1u6jyz6qfk4ood8u4qotw7go9jj0p-cfpnh7omy86xcgoh45vau2kaj 192.168.1.10:2377
To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```
## Postgresql
```bash
sudo apt install postgresql postgresql-contrib -y
sudo curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add

sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
sudo apt install pgadmin4 -y
```
### Configure Postgresql
By default, Postgres uses a concept called “**roles**” to handle authentication and authorization. These are, in some ways, similar to regular Unix-style users.  
The installation procedure created a user account called **postgres**.
```bash
sudo -i -u postgres
psql
```
To exit use this command
```bash
\q
```
1. Create User
```bash
createuser --interactive
```
Another way if you like linux command 
```bash
sudo -u postgres createuser --interactive
Output
Enter name of role to add: sammy
Shall the new role be a superuser? (y/n) y

```
2. Create DB
```bash
    createdb sammy
```
Linux Command
```bash
sudo -u postgres createdb sammy
```
3. Sync with Linux
To log in with ident based authentication, you’ll need a Linux user with the same name as your Postgres role and database.
```bash
sudo adduser sammy
```
Now you can login by this command:
```bash
sudo -i -u sammy
psql
```
Or by that way
```
sudo -u sammy psql
```
After tolig you can switch DB by ``` psql -d postgres ```
To check about connaction: ``` \conninfo ```  
[How To Install PostgreSQL on Ubuntu 20.04 [Quickstart]](https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-20-04-quickstart) 
### Service
```bash
sudo systemctl stop postgresql
sudo systemctl disable postgresql
```
## MongoDB
```bash
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
sudo apt-get install gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl disable mongod
```
## Jekyll
```bash
#jekyll
sudo snap install ruby --classic
echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
gem install jekyll bundler
```
## Terminal Tool
### ZSH
```zsh
sudo apt-get install zsh -y
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo '# Install Ruby Gems to ~/gems' >> ~/.zshrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.zshrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.zshrc
sudo apt-get install vim -y
sudo apt-get install konsole terminator -y
chsh -s $(which zsh)
```
### Fish
```bash
sudo apt-get install fish fish-common ondir zsh-syntax-highlighting
```
## Software
### Video Edit - PEEK
```vim
sudo add-apt-repository ppa:peek-developers/stable
sudo apt update
sudo apt install peek
```
### QA tester - screen record and capture
```zsh
sudo apt install flameshot kazam -y
```
### Git, PHP storm, gitkraken, postman, utube, hollyword
```zsh
sudo apt install git-flow git-cola -y
sudo snap install gitkraken --classic
sudo snap install postman
sudo snap install phpstorm --classic
sudo snap install utube
sudo apt-get install hollywood 
```
### gnome weather
```bash
sudo add-apt-repository ppa:gnome-shell-extensions
sudo apt-get update
sudo apt-get install gnome-shell-extension-weather
sudo dpkg -i mysql-workbench-community-dbgsym_8.0.23-1ubuntu20.04_amd64.deb
```
## Clean APT and configure source list recheck
```bash
sudo apt-get autoclean
sudo apt-get autoremove
software-properties-gtk
```
