# Final task from Itransition DevOps courses

In this task an AMI with LAMP stack installed was created using bash_provision.sh as User Data.

NPM is installed with Ansible playbook (server public ip have to be specified in file hosts.cfg).

Insbtance creation can be done with AWS Cloudformation (file cloudfrom.yml).

File static_sites.sh contains bash scripts to install Wordpress and Gatsby with hello-world application.

On screenshots you can see Application Load Balancer configuration with 2 target groups for different apps.