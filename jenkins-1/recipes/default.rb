#
# Cookbook Name:: jenkins-1
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
# This recipe include steps for installing jenkins only on ubuntu machine
# After the successfull installation it will start the jenkins service so that jenkins UI become accissible 
 

execute "wget-jenkins" do
  command "wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -"
  ignore_failure true
  action :nothing
end

execute "echo-jenkins" do
  command "sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'"
   ignore_failure true
  action :nothing
end

# Install jenkins on ubuntu by apt-get install command
execute "wget-jenkins" do
  command " apt-get install jenkins"
 ignore_failure true
  action :nothing
end

# Start the jenkins service 
package "jenkins"
 
service "jenkins" do
  supports [:stop, :start, :restart]
  action [:start, :enable]
end
