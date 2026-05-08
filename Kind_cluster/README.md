# Execute cluster shell
./Kind_kubectl.sh

# Execute config file
kind create cluster --name tws-cluster --config=Kind_config.yml
