# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "debian/stretch64"
  config.vm.provider "virtualbox" do |v|
		v.memory = 1024
		v.cpus = 2
  end
  if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
		config.vm.synced_folder "shared", "/shared", mount_options: ["dmode=777,fmode=777"]
	else
		config.vm.synced_folder "shared", "/shared"
	end

end
