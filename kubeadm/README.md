# To describe details of a pod
kubectl describe pods/<pod name> -n <namespace Name>

# To enter into the shell of a container
kubectl exec -it nginx-pod -n nginx -- bash
