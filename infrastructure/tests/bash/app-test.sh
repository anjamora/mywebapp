set -ruo pipefail

cd ../../app

terraform init
terraform apply -auto-approve

sleep 60

terraform output -json |\
jq -r '.isntance_ip_addr.value' |\
xargs -I {} curl http://{}:8080 -m 10

terraform destroy -auto-approve