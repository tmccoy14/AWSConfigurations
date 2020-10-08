## AWS CONFIGURATIONS FOR A NEWLY CREATED AWS ACCOUNT

When creating a new AWS account, there are a few initial steps that need to be taken in order to ensure security and compliance. The first thing that needs to be done is to create some IAM groups and policies for future users. Secondly, ensuring each user is enabling MFA in order to add the extra layer of account security.

## PREREQUISITES

In order to be able to successfully create the following resources with Terraform, you will need the [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli) tool installed with a version of atleast `v0.12.19`.

You will also need the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) tool installed with the account admin AWS credentials configured locally. See the [AWS Docs](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) for more information on that.

## CREATING TERRAFORM RESOURCES

We are using [Terraform](https://www.terraform.io/), an Infrastructure as Code (IaC) tool, to manage our AWS resources we are creating. We are using IaC in order to make this a repeatable and consistent process for how ever many accounts this needs to be ran for.

### SETUP IAM

```
The IAM Terraform module will configure IAM groups and policies for different types of users that will be accessing the AWS account.

# navigate to iam directory
$ cd terraform/iam

# create iam resources
$ terraform apply -auto-approve
```
