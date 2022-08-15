# Noctua Application Deployment

This repository enables the deployment of the noctua editor (which includes 
minerva, barista, golr and noctua) locally, using self-generated GO-CAM models (in the form of .ttl files).    

## Deploy a version of the Noctua editor (including minerva, barista, golr and noctuar):
  - important ansible files:
    - vars.yaml
    - docker-vars.yaml
    - stage.yaml
    - start_services.yaml
  
## Deployment artifacts generated:
  - blazegraph journal
  - Solr Index
  - Cloned repositories including:
    - noctua-form, noctua-landing-page, noctua-models, go-site.
  - docker-compose and configuration files are generated from templates.

#### AWS TERRAFORM BACKEND 

- backend.tf
  - Points to terraform backend. See production/backend.tf.sample

### PROVISON 

# Modify as needed
cp ./production/backend.tf.sample aws/backend.tf

# Deploy
Use Python script to deploy. Note the script has a -dry-run option.

>pip install go-deploy==0.3.0 # requires python >=3.8.5
>go-deploy -h

# We append the date to the terraform workspace name. As as example we will use production-yy-mm-dd

# Modify as needed
cp ./production/config-instance.yaml.sample config-instance.yaml
go-deploy -init -c config-instance.yaml -w production-yy-mm-dd -d aws -verbose

# ansible inventory file has the public ip 
cat production-yy-mm-dd.cfg

# Modify as needed and be sure to set host to public ip address
# Be sure to set the docker_hub_user to the docker account where minerva and noctua images live 
# They now live under aessiari you can build them and push to your own account 
cp ./production/config-stack.yaml.sample config-stack.yaml
go-deploy -c config-stack.yaml -w production-yy-mm-dd -d aws -verbose

### Access noctua from a browser
- Use `http://{public_ip}:8080` 

### Destroy Instance And Stack

```sh
# Make sure you pointing to the correct workspace
terraform -chdir=aws workspace show
terraform -chdir=aws destroy
```
