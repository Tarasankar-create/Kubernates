## Install Prometheus and grafana using helm
# Check Helm
``` bash
helm version
```
# If Helm isn't installed:
``` bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
chmod 700 get_helm.sh
./get_helm.sh
```
# Add the Prometheus community repository
``` bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

# Create a monitoring namespace
``` bash
kubectl create namespace monitoring
```
# Install Prometheus + Grafana
``` bash
helm install monitoring prometheus-community/kube-prometheus-stack \
  --namespace monitoring
```
# Access Prometheus
``` bash
kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-prometheusa 9090:9090 --address=0.0.0.0
```
# Access Grafana
``` bash
kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80 --address=0.0.0.0
```
# Get Grafana password

# Username:
``` bash
admin
```
# Get the password:
``` bash
kubectl get secret -n monitoring monitoring-grafana \
  -o jsonpath="{.data.admin-password}" | base64 -d
echo
```
