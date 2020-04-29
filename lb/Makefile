.PHONY: lb

lb:
	docker container ls --filter "name=haproxy" | grep "haproxy" \
		|| docker run \
			--detach \
			--rm \
			--tty \
			--name haproxy \
			--hostname haproxy \
			--publish 80:9999 \
			--mount type=bind,source=${PWD}/haproxy.cfg,target=/usr/local/etc/haproxy/haproxy.cfg \
			haproxy:2.1

reload:
	docker kill -s HUP haproxy
