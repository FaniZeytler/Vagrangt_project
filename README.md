# Consul Lab Exercise
1) Upload all files to the same directory
2) Run "vagrant up"

* Consul UI will be available at "http://localhost:8500/ui"
* Apache server page will be available at "http://localhost:8080"

* To connect to the VM with consul server - "vagrant ssh consulserver"
* To connect to the VM with Agent server+Consul agent - "vagrant ssh apache"

<h4>Files:</h4>

<b>000-default.conf,ports.conf: </b> Files for changing the listening port of Apache.

<b>consul.service: </b> Service of Consul

<b>index.html </b> Page that Apache displays.

<b>provision_apache.sh: </b> Commands to configure Apache.

<b>provision.consul.sh: </b>Commands to install Consul.

<b>provision_consul_service.sh: </b> Commands to insert the file of consul.service to the VM.

<b>Vagrantfile: </b>Main file of vagrant

<b>web.json: </b>Configuration file of the consul service and health check for the Apache VM.

