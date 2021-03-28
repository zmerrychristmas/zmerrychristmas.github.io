# login sudo first
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-add-repository universe
sudo add-apt-repository ppa:ondrej/php
sudo add-apt-repository ppa:gerardpuig/ppa
sudo add-apt-repository ppa:otto-kesselgulasch/gimp
sudo add-apt-repository ppa:openshot.developers/ppa
sudo add-apt-repository -y ppa:teejee2008/ppa
sudo apt-get update
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
#java
sudo apt-get install openjdk-11-jdk -y
# lamp
sudo apt install apache2 -y
sudo ufw allow in "Apache"
sudo apt-get install -y mysql-server mysql-client libmysqlclient-dev libpq-dev
sudo apt install php libapache2-mod-php php-mysql -y
sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
sudo apt-get install php-cli unzip -y
# ruby on rails
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvms
ruby -v
gem install bundler
# git
sudo apt-get install git
git config --global color.ui true
git config --global user.name "Nguyen Huy Binh"
git config --global user.email "huybinh.ad@gmail.com"
ssh-keygen -t rsa -b 4096 -C "huybinh.ad@gmail.com"
#composer
curl -sS https://getcomposer.org/installer -o composer-setup.php
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo apt-get install -y zip unzip software-properties-common 
sudo apt-get install -y php7.4 php7.4-gd php7.4-mbstring php7.4-xml php-zip php7.4-mysql
# python
sudo apt-get install -y python2
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
sudo python2 get-pip.py
pip3 install scrapy
sudo apt-get install -y python3-pip
# nodejs
sudo apt install npm -y
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
nvm list-remote
nvm install v14.0.0
nvm use v14.0.0
npm install --global yarn
# docker
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
sudo usermod -aG docker ${USER}
sudo apt-get install -y py-pip python3-dev libffi-dev openssl-dev gcc libc-dev rust cargo make
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
source ~/.bashrc
sudo mysql_secure_installation
sudo add-apt-repository ppa:rednotebook/stable
sudo apt-get update
sudo apt-get install rednotebook -y
# docker swarm
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt install docker-ce
#postgresql
sudo apt install postgresql postgresql-contrib -y
sudo curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add

sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
sudo apt install pgadmin4 -y

#jekyll
sudo snap install ruby --classic
echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
gem install jekyll bundler
#zsh
sudo apt-get install zsh -y
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo '# Install Ruby Gems to ~/gems' >> ~/.zshrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.zshrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.zshrc
sudo apt-get install vim -y
sudo apt-get install konsole terminator -y
#fish shell
sudo apt-get install fish fish-common ondir zsh-syntax-highlighting
#check ppa
sudo systemctl stop postgresql
sudo systemctl disable postgresql
# sudo systemctl enable postgresql
# Shotcut (Video Editing)
sudo apt install snapd
sudo snap install shotcut --classic
sudo snap install code --classic
sudo snap install sublime-text --classic
# screen recorder
sudo add-apt-repository ppa:peek-developers/stable
sudo apt update
sudo apt install peek
# extension
## weather 
sudo add-apt-repository ppa:gnome-shell-extensions
sudo apt-get update
sudo apt-get install gnome-shell-extension-weather
sudo dpkg -i mysql-workbench-community-dbgsym_8.0.23-1ubuntu20.04_amd64.deb
## other
sudo apt install git-flow git-cola -y
sudo snap install gitkraken --classic
sudo snap install postman
sudo snap install phpstorm --classic
sudo snap install utube
sudo apt-get install hollywood 
# mongo db
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
sudo apt-get install gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl disable mongod
# screenshot edit: QA tester
sudo apt install flameshot kazam -y
sudo apt-get autoclean
sudo apt-get autoremove
software-properties-gtk
chsh -s $(which zsh)
