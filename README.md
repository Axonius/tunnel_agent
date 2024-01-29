The Dockerfile of the axonius/tunnel image, not supposed to ever change.

Running it supposed to be as follows:
	`docker run -d -e PROXY_USERNAME="{proxy_username}" -e PROXY_ENABLED="{proxy_enabled}" -e PROXY_ADDR="{proxy_addr}" -e PROXY_PORT="{proxy_port}" -e PROXY_PASSWORD="{proxy_password}"  -e OVPN_CONF=$(cat $PWD/conf/user.ovpn | base64 -w0)--net=host --privileged --name axonius_tunnel axonius/tunnel`
	OR
	`docker run -d -e PROXY_USERNAME="{proxy_username}" -e PROXY_ENABLED="{proxy_enabled}" -e PROXY_ADDR="{proxy_addr}" -e PROXY_PORT="{proxy_port}" -e PROXY_PASSWORD="{proxy_password}"  -e OVPN_CONF=$(cat $PWD/conf/user.ovpn | base64 -w0) --net=host --name axonius_tunnel axonius/tunnel`

Example K8S yaml:

    apiVersion: v1
	kind: Pod
	metadata:
	  name: axonius-tunnel
	spec:
	  containers:
		- name: ovpn
		  image: axonius/tunnel:stable
		  tty: true
		  imagePullPolicy: Always
		  env:
		  - name: OVPN_CONF
			value: {BASE64_CONFIG}
			name: PROXY_ENABLED
            value: {proxy_enabled}
            name: PROXY_ADDR
            value: {proxy_addr}
			name: PROXY_PORT 
            value: {proxy_port}
            name: PROXY_USERNAME
            value: {proxy_username}
			name: PROXY_PASSWORD
            value: {proxy_password}
		  securityContext:
			privileged: true
			capabilities:
			  add:
				- NET_ADMIN

This yaml can be used in any k8s based platform such as AWS EKS, RedHat Openshift and more

For ECS usage please refer docs.axonius.com
