#

# Cookbook Name:: jenkins-config
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


# Download jenkins-cli.jar which is required for using jenkins through command line
execute "wget-jenkins-cli.jar" do
  command " wget http://"+node[:IP]+":8080/jnlpJars/jenkins-cli.jar"
  ignore_failure true
  action :run
end

# This loop will traverse and install the list of plugins defined in /attributes/default.rb file on the jenkins ip address
node[:Jenkins_Plugins].each do |plugin|
   execute "jenkins-plugins-installation" do
   command "java -jar jenkins-cli.jar -s http://"+node[:IP]+":8080/ install-plugin " + plugin 
   ignore_failure true
   action :run
  end
end

#This will place the temp-job.xml file on target jenkins. temp-job.xml is stored in /files directory
cookbook_file '/var/lib/jenkins/jobs/temp-job.xml' do
  source 'temp-job.xml'
  mode '0644'
end

# After the Job.xml is placed below commands will create new job in jenkins with the configuration specified in temp-job.xml
execute "create-job" do
  command " java -jar jenkins-cli.jar -s http://"+node[:IP]+":8080/ create-job "+node[:new_job_name]+" < /var/lib/jenkins/jobs/temp-job.xml "
  ignore_failure true
  action :run
end


