# NETTOOLBOX
This is a small container that only contains a lot of different networks tools to be able to understand your container platform.
Busybox is a great container that can do a lot of fun but is missing a few tools like `curl, nslookup, ping` and more.

## Deployment
This is a standard docker container and can be run on arm64 and amd64 platform.
If you need this container for any other platforms, open a request ticket in Github.

### Kubernetes
You have two options, either you create a job `kubectl create job nettoolbox --image=isstech/nettoolbox:latest -- sleep 9999`
Or you can apply the yaml file that you can find in the kubernetes directory, `kubectl apply -f ./kubernetes/deployment.yaml`

When the image are running you can then run `kubectl exec -it <pod name> -- /bin/bash`

## Change Log
Please see the CHANGE.md file for more information.

## Contribution
Feel free to help us to get this container to including all necessary tools.
To be able to help us improving this,
- Create a Fork
- Make your changes
- Test your changes
- Update the CHANGE.md file
