.PHONY: plugin, up, rsync, provision, halt, ssh, nginx, lb

plugin:
	vagrant plugin install vagrant-hosts
up: plugin
	vagrant up
	chmod 600 .vagrant/machines/*/virtualbox/private_key
rsync:
	vagrant rsync
provision:
	vagrant provision
halt:
	vagrant halt
destroy:
	vagrant destroy

nginx:
	vagrant ssh app1 -c "cd nginx && make nginx-1"
	vagrant ssh app2 -c "cd nginx && make nginx-2"
	vagrant ssh app3 -c "cd nginx && make nginx-3"

lb:
	vagrant ssh lb -c "cd lb && make lb"

test:
	curl --silent 192.168.1.10 | grep "h1" && sleep 0.5
	curl --silent 192.168.1.10 | grep "h1" && sleep 0.5
	curl --silent 192.168.1.10 | grep "h1" && sleep 0.5
	curl --silent 192.168.1.10 | grep "h1" && sleep 0.5
	curl --silent 192.168.1.10 | grep "h1" && sleep 0.5
	curl --silent 192.168.1.10 | grep "h1"
