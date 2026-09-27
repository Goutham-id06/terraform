
# Module-Three-Tier apply flow 
```
terraform apply -target=module.vpc -auto-approve
terraform apply -target=module.bastion -auto-approve
terraform apply -target=module.frontend-ec2 -auto-approve
terraform apply -target=module.backend-ec2 -auto-approve
terraform apply -target=module.frontend_alb -auto-approve
terraform apply -target=module.backend_alb -auto-approve
terraform apply -target=module.rds -auto-approve
```
- now connect to backend and frontend ec2s deploy the application
- in frontend connfig file give backend loadbalncer url
- next backend .env give rds detils 
- next deploy both frontend and backend
# apply reming  mmodules
```
terraform apply -target=module.frontend_launchtemplate
terraform apply -target=module.backend_launchtemplate
terraform apply -target=module.asg-backend
terraform apply -target=module.asg-frontend

```
