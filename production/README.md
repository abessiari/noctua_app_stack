# Noctua Application Deployment

This repository enables the deployment of the noctua stack to AWS. It includes 
minerva, barista, and noctua and it points to an external amigo instance.     

## Deploy a version of the Noctua editor (including minerva, barista, noctua):
  - Important ansible files:
    - vars.yaml
    - docker-vars.yaml
    - s3-vars.yaml
    - stage.yaml
    - start_services.yaml
  
## Artifacts Deployed To Staging directory On AWS:
  - blazegraph.jnl
  - Cloned repositories:
    - noctua-form, noctua-landing-page, noctua-models, go-site and noctua-visual-pathway-editor.
  - s3 credentials used to push apache logs to s3 buckets
  - github OAUTH client id and secret
  - docker-production-compose and various configuration files from template directory

## Install Python Deploy Script
Use Python script to deploy. Note the script has a <b>-dry-run</b> option.

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
