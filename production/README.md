# Noctua Application Deployment

This repository enables the deployment of the noctua editor (which includes 
minerva, barista, golr and noctua) locally, using self-generated GO-CAM models (in the form of .ttl files).    

## Deploy a version of the Noctua editor (including minerva, barista, noctua):
  - important ansible files:
    - vars.yaml
    - docker-vars.yaml
    - s3-vars.yaml
    - stage.yaml
    - start_services.yaml
  
## Deployment artifacts generated:
  - Copy blazegraph.jnl
  - Cloned repositories:
    - noctua-form, noctua-landing-page, noctua-models, go-site and noctua-visual-pathway-editor.
  - docker-compose and configuration files are generated from templates.

## Install Python Deploy Script
Use Python script to deploy. Note the script has a -dry-run option.

```
>pip install go-deploy==0.3.0 # requires python >=3.8.5
>go-deploy -h
```

## AWS TERRAFORM BACKEND 

- backend.tf
  - Use S3 terraform backend. See production/backend.tf.sample

## PROVISON 

Copy sample files and modify as needed. For the terraform worksapce we append the date.
As an example we use production-yy-mm-dd

```
cp ./production/backend.tf.sample aws/backend.tf
cp ./production/config-instance.yaml.sample config-instance.yaml
go-deploy -init -c config-instance.yaml -w production-yy-mm-dd -d aws -verbose
cp ./production/config-stack.yaml.sample config-stack.yaml
go-deploy -c config-stack.yaml -w production-yy-mm-dd -d aws -verbose
```

### Access noctua from a browser
- Use `http://{public_ip}:8080` 

### Destroy Instance And Stack

```sh
# Make sure you pointing to the correct workspace
terraform -chdir=aws workspace show
terraform -chdir=aws destroy
```
