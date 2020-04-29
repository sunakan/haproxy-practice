define nginx
	docker container ls --filter "name=nginx" | grep "nginx" \
		|| docker run \
			--detach \
			--rm \
			--interactive \
			--tty \
			--name nginx \
			--hostname nginx \
			--publish 8080:80 \
			--mount type=bind,source=${PWD}/index-$1.html,target=/usr/share/nginx/html/index.html \
			nginx:stable
endef

.PHONY: nginx-1, nginx-2, nginx-3, clean, restart

nginx-1:
	$(call nginx,1)
nginx-2:
	$(call nginx,2)
nginx-3:
	$(call nginx,3)

clean:
	docker container ls --quiet --filter "name=nginx" | xargs -I{} docker stop {}
