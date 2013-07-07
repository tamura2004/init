#!/bin/bash

var=1.9
ruby=ruby-1.9.3-p448
 
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

# Install Sublime Text3
# wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3047_amd64.deb
# dpkg -i sublime-text_build-3047_amd64.deb

# Install Chef
gem install chef --no-ri --no-rdoc

# Install Knife
cd
git clone git://github.com/matschaffer/knife-solo.git
cd knife-solo
rake install

# # Inisialize chef repository
# cd
# knife solo init chef-repo
# cd chef-repo
# git init
# git add .
# git commit -m 'Initialize chef repository'



