## INTRO
<hr>

This is just a test or POC using a combination of tools like: AWK, K8s and Terraform.

The code will deploy a managed K8s in AWS and create two nginx deployment: one for private connections and one for public connections.

Public Nginx's deployment will be depend on the staus of the Private nginx.

## SETUP
<hr>

* 2 highly available [nginx](https://nginx.org/) service in cluster on [Kubernetes](https://kubernetes.io/).
* The first `nginx` will be reachable from the public internet (`public`) and the second one just be reachable inside the cluster (`private`).
* A new release of the ngnix will trigger the private to deploy first and public to deploy after.
* Deployment will always be Private -> Public.

## STEPS
<hr>

1. Install AWS CLI "https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html".
2. Create a terraform user from the AWS console with AccessKey auth only.
3. Create new Security Credential from the account in AWS. Take Note of them.
4. Use them to run "aws configure" from the AWS CLI.
5. Create a first S3 bucket using AWS CLI. This will be used by terraform to preserve the remote state.
``` aws s3api create-bucket --bucket "my-terraform-bucket-alef" --region "eu-west-1" --create-bucket-configuration LocationConstraint=eu-west-1```
6. Go in folder "terraform_infrastructure" and run "terraform apply" -> This will create an example of the kubeconfig file in the terraform's folder. You can use it to configure kubectl in another shell.
7. Go in folder "terraform_k8s_config" and run "terraform apply"

__In case of name conflict issues. change the "name_prefix" in the variable.tf for "terraform_infrastructure".__