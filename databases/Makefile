clean:
	@rm -rf .terra*

dev: dev-apply
dev-apply: clean
	@terraform init -backend-config=env/dev-backend.tfvars -no-color
	@terraform apply -auto-approve -var-file=env/dev.tfvars -no-color

prod: prod-apply
prod-apply: clean
	@terraform init -backend-config=env/prod-backend.tfvars -no-color
	@terraform apply -auto-approve -var-file=env/prod.tfvars -no-color

dev-destroy: clean
	@terraform init -backend-config=env/dev-backend.tfvars -no-color
	@terraform destroy -auto-approve -var-file=env/dev.tfvars -no-color

prod-destroy: clean
	@terraform init -backend-config=env/prod-backend.tfvars -no-color
	@terraform destroy -auto-approve -var-file=env/prod.tfvars -no-color
