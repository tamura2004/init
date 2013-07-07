#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#
# Cookbook Name:: hello
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

packages = %w{
	byobu
	openssh-server
	etckeeper
	git
	tig
	iotop
	ifstat
	dstat
	linux-headers-generic
	ntp
	vim-nox
	nginx
}

packages.each do |pkg|
	package pkg do 
		action :install
	end
end

service "nginx" do
	supports status: true, restart: true, reload: true
	action [ :enable, :start ]
end

user "nginx" do
	comment "nginx"
	home "/home/nginx"
	shell "/bin/bash"
	password "nginx"
	supports :manage_home => true
	action [:modify, :create]
end

template "nginx.conf" do
	path "/etc/nginx/nginx.conf"
	source "nginx.conf.erb"
	owner "root"
	group "root"
	mode 0644
	notifies :reload, 'service[nginx]'
end

gem_packages = %w{
	rails
	roo
	ruby-shadow
	spreadsheet
	rspec
	minitest
}

gem_packages.each do |pkg|
	gem_package pkg do
		options "--no-ri --no-rdoc"
		action :install
	end
end
