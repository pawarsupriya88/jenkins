These include two cookbooks:
1) jenkins-1
   - jenkins-1 include recipe for installing jenkins and start the jenkins service after successfull installation
2) jenkins-config
  - jenkins-config cookbook install the list of plugins specified and create new job


PLATFORM - ubuntu

Follow below steps in order to use these cookbooks for installing and configuring jenkins
1. Add role (jenkins-server) in chef
   - vi /root/chef-repo/roles/jenkins-server.rb
     name "jenkins-server"
     description "A role to configure jenkins-server"
     run_list "recipe[jenkins-1]", "recipe[jenkins-config]"
   - knife role from file /root/chef-repo/roles/jenkins-server.rb
   - knife role show jenkins-server -Fjson
2. Bootstrap new node
   - knife bootstrap <ip> -r 'role[jenkins-server]' -N <'name'> -x <user> -P <password> --sudo
3. Modify chef-client ip address in file /root/chef-repo/cookbooks/jenkins-config/attributes/default.rf
4. Modify / Add / Delete list of plugins in the same file (/root/chef-repo/cookbooks/jenkins-config/attributes)
5. Put the job.xml file which you want to create after successfull installation of jenkins in the derectory /root/chef-repo/cookbooks/jenkins-config/files/default
6. Run the chef-client on chef-node.
