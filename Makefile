

apply:
	packer build Packer/builder.json
	terraform init
	terraform plan -var-file="env/backend.tfvars" -out="backplan.tfplan" 
	terraform apply "backplan.tfplan"

destroy: 
	terraform destroy -- auto-approve

