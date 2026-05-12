# To create nameSpace
kubectl create namespace <your-namespace-name>

# To describe details of a pod
kubectl describe pods/<podName> -n <namespaceName>

# To enter into the shell of a container
kubectl exec -it nginx-pod -n nginx -- bash

# To apply deployment
kubectl apply -f deployment.yml

# To see the deployment
kubectl get deployment -n nginx

# To see the pods
kubectl get pods -n nginx

# To scale pods
kubectl scale deployment/nginx-deployment -n nginx --replicas=5

# To reduce to 1
kubectl scale deployment/nginx-deployment -n nginx --replicas=1

# To update or rollout update of nginx to lower version without stopping pods
kubectl set image deployment/nginx-deployment -n nginx nginx=nginx:1.27.3

# To get more details about pods
kubectl get pods -n nginx -o wide

## To apply replicasets
kubectl apply -f replicasets.yml

# To get replicasets
kubectl get replicasets -n nginx
