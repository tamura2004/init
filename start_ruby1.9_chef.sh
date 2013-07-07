#!/bin/bash

var=1.9
ruby=ruby-1.9.3-p448
 
cd

# Install Libraries for build
apt-get install -y zlib1g-dev libssl-dev libreadline6-dev libyaml-dev libxml2-dev libxslt-dev make rake git curl

if [ ! -e /usr/local/bin/ruby ]; then
  # create src directory
  cd
  mkdir src
  cd src
   
  # Download Ruby
  wget ftp://ftp.ruby-lang.org/pub/ruby/${var}/${ruby}.tar.bz2
  tar xjf ${ruby}.tar.bz2
   
  # Configure and Compile
  cd ${ruby}
  ./configure
  make
  make install
   
  cd
fi

# Install Chef
result=$(knife -v | grep -c Chef)
if [ $result -eq 0 ]; then
  gem install chef --no-ri --no-rdoc
else
  echo "chef already installed"
fi

# Install Knife
if [ ! -d ~/knife-solo ]; then
  cd
  git clone git://github.com/matschaffer/knife-solo.git
  cd knife-solo
  rake install
  sed -i "$a\knife[:solo_path] = '/tmp/chef-solo'" ~/.chef/knife.rb
else
  echo "knife already installed"
fi
