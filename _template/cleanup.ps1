terraform destroy --auto-approve
Remove-Item -Recurse -Force .terraform*
Remove-Item -Recurse -Force terraform.tfstate*

# terraform destroy --auto-approve
# rm -rf .terraform*
# rm -rf terraform.tfstate*