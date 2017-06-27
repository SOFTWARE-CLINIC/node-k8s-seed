# Node k8s Seed

> A seed project for simple Node.js web application running on Kubernetes.

## Create a Minikube cluster

```
$ minikube start
```

Set the Minikube context. The context is what determines which cluster `kubectl`
is interacting with. You can see all your available contexts in the
`~/.kube/config` file.

```
$ kubectl config use-context minikube
```

Verify that `kubectl` is configured to communicate with your cluster.

```
$ kubectl cluster-info
```

## Create a Docker container image

You can build the image using the same Docker host as the Minikube VM,
so that the images are automatically present. To do so, make sure you are using
the Minikube Docker daemon.

```
$ eval $(minikube docker-env)
```

> *Note:* Later, when you no longer wish to use the Minikube host, you can udo
> this change by running `eval $(minikube docker-env -u)`.

```
$ docker build -t node-k8s-seed:v0.0.1 .
```

## Create a Deployment

A Kubernetes Pod is a group of one or more Containers, tied together for the
purposes of administration and networking. The Pod in this repository has only
one Container. A Kubernetes Deployment checks on the health of the Pod and
restarts the Pod's Container if it terminates.

Use the `kubectl run` command to create a Deployment that manages a Pod. The Pod
runs a Conatiner based on the `node-k8s-seed:v0.0.1` Docker image.

```
$ kubectl run node-k8s-seed --image=node-k8s-seed:v0.0.1 --port=8080
```

View the Deployment `$ kubectl get deployments`.

View the Pod `$ kubectl get pods`.

View cluster events `$ kubectl get evetns`.

View the `kubectl` configuration `$ kubectl config view`.

## Create a Service

By default, the Pod is only accessible by its internal IP address within the Kubernetes
cluster. To make the `node-k8s-seed` Container accessible from outside the Kubernetes
virtual network, you have to expose the Pod as a Kubernetes Service.

From your development machine, you can expose the Pod to the public internet using
the `kubectl expose` command.

```
$ kubectl expose deployment node-k8s-seed --type=LoadBalancer
```

View the Service `$ kubectl get services`.

> The `--type=LoadBalancer` flag indicates that you want to expose your Service
> outside of the cluster. On cloud providers that support load balancers, an external
> IP address would be provisioned to access the Service. On Minikube, the `LoadBalancer`
> type makes the Service accessible through the `minikube service` command.
>
> ```
> $ minikube service node-k8s-seed
> ```
> 
> This automatically opens up a browser window using a local IP address that
> serves your app and shows the home page.

```
$ kubectl logs <POD-NAME>
```

## Update the app

Modify the app code and build a new version of Docker container image.

```
docker build -t node-k8s-seed:v0.0.2 .
```

Update the image of your Deployment

```
$ kubectl set image deployment/node-k8s-seed node-k8s-seed=node-k8s-seed:v0.0.2
```

Run the app again to view the changes

```
$ minikube service node-k8s-seed
```

### Clean up

```
$ kubectl delete service node-k8s-seed
$ kubectl delete deployment node-k8s-seed
```

Optionally, stop Minikube

```
$ minikube stop
```
