ls
terraform init
cd terraform/
terraform init
terraform plan -var-file=envVars --out tfplan
terraform plan -var-file=envVars --out tfplan
terraform plan -var-file=envVars --out tfplan
terraform apply "tfplan"
exit
