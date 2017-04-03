# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = 'hashicorp/precise64'

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network 'forwarded_port', guest: 3000, host: 3000
  config.vm.network 'forwarded_port', guest: 35_729, host: 35_729

  config.ssh.username = 'vagrant'

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider 'virtualbox' do |vb|
    #   # Display the VirtualBox GUI when booting the machine
    #   vb.gui = true
    #
    #   # Customize the amount of memory on the VM:
    vb.memory = '2048'
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision 'shell', inline: <<-SHELL, privileged: false
    echo "-----------------------------STARTING BOMBHILLS VAGRANT"
    sed -i '1iforce_color_prompt=yes' ~/.bashrc
    echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc

    echo "-----------------------------INSTALLING ESSENTIALS"
    export LANGUAGE="en_US.UTF-8"
    export LANG="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
    localedef -v -c -i en_US -f UTF-8 en_US.UTF-8
    locale-gen en_US.UTF-8
    sudo apt-get update
    sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev libcurl4-openssl-dev curl wget chrpath libxft-dev
    sudo apt-get install -y git
    sudo apt-get install imagemagick -y
    sudo apt-get install -y postgresql libpq-dev
    sudo apt-get install libfreetype6 libfreetype6-dev
    sudo apt-get install libfontconfig1 libfontconfig1-dev

    echo "-----------------------------INSTALLING NODE"
    curl -sL https://deb.nodesource.com/setup_6.x | sudo bash -
    sudo apt-get install -y nodejs
    echo "prefix=/home/vagrant/.npm-packages" >> /home/vagrant/.npmrc


    echo "-----------------------------INSTALLING PHANTOMJS"
    export PHANTOM_JS="phantomjs-2.1.1-linux-x86_64"
    wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2
    sudo tar xvjf $PHANTOM_JS.tar.bz2
    sudo mv $PHANTOM_JS /usr/local/share
    sudo cp /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin


    echo "-----------------------------INSTALLING RUBY"
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -sSL https://get.rvm.io | bash
    source /usr/local/rvm/scripts/rvm
    source $HOME/.rvm/scripts/rvm || source /etc/profile.d/rvm.sh
    echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> .bashrc
    sudo usermod -a -G rvm vagrant
    rvm get stable
    rvm install "$(< /vagrant/.ruby-version)"
    rvm use "$(< /vagrant/.ruby-version)"

    echo "-----------------------------SETTING UP DATABASE"
    sudo sudo -u postgres psql -1 -c "CREATE USER vagrant WITH PASSWORD 'secret';"
    sudo sudo -u postgres psql -1 -c "ALTER USER vagrant WITH SUPERUSER;"
    sudo service postgresql start


    echo "-----------------------------SETTING UP PROJECT"
    #mkdir -p ~/fog/bombhills/images
    #mkdir /vagrant/public
    #ln -s ~/fog/bombhills/images /vagrant/public doesn't work on windows 10
    gem install bundler
    gem update --system
    cd /vagrant
    bundle install
    rails db:setup


    echo "-----------------------------SETUP COMPLETE"
    echo "-----------------------------ENTER VIRTUAL MACHINE WITH"
    echo "-----------------------------vagrant ssh"
    echo "-----------------------------START SERVER WITH"
    echo "-----------------------------cd /vagrant"
    echo "-----------------------------rails s"
    echo "-----------------------------and visit localhost:3000 in browser"
  SHELL
end
