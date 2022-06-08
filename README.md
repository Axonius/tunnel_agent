The Dockerfile of the axonius/tunnel image, not supposed to ever change.

Running it supposed to be as follows:
	`docker run -d --net=host --privileged --name axonius_tunnel axonius/tunnel`

Example K8S yaml:

    apiVersion: v1
	kind: Pod
	metadata:
	  name: axonius_tunnel
	spec:
	  containers:
	    - name: axonius_tunnel
	      image: axonius/tunnel:latest
	      tty: true
	      imagePullPolicy: Always
	      securityContext:
	        privileged: true
	        capabilities:
	          add:
        	    - NET_ADMIN

For ECS usage please refer docs.axonius.com
