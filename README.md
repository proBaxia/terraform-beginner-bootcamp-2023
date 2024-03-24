# Terraform Beginner Bootcamp 2023

## Semantic Versioning 1.0.1


This project is the utiliz semantic versioning for its tagging. [semver.org](http://semver.org/)

The genaral format:

 **MAJOR.MINOR.PATCH**, eg.  "1.0.1" 
- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format. 

## Install Terraform CLI 


### Considerration with the Terraform CLI Changes 
The Terraform CLI installation instructions have changed due to gpg keyring changes. so we needed refer to latest install CLi instructions via Terrafrom Documentation and change the scripting for install .

[install Terraform cli](https://developer.hashicorp.com/terraform/install?product_intent=terraform)

### Consideration for Linux Distribution
This project is build against ubuntu.
Please consider cheching you Linux Distribution and change accordingly to the distribution needs.

[How to Check OS Version in linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version 

$ cat /etc/os-release

``` PRETTY_NAME="Ubuntu 22.04.4 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.4 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy

```
### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depreciation issues we notice that bash scripts steps were considerable amount more code. so we deside to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) Tidy.
- This allow us an easier to debug and execute manually Terraform CLI install 
- This will allow better portablity for other other project tha need to install Terraform CLI

### Shebang Considerations 

A Shebang (prounced She-bang) tells the bash script what program that will interpet the script. eg . ' #!/bin/bash '

Chatgpt recommend this format for bash : ' #!/usr/bin/env bash '

- for portability for different OS distributions 
- will search the user's PATH for the bash executable 

When executing the bash script we can use the './' shorthand notiation to execute the bash script.

https://en.wikipedia.org/wiki/Shebang_(Unix)


#### Linux Permission Considerations 

in order to make ur bash scripts executable  we need to change linux permission for the fix to be executable at the user mode 

 
> chmod u+x ./bin/install_terraform_cli


alternatively

> chmod 774 ./bin/install_terraform_cli  

https://en.wikipedia.org/wiki/Chmod

### Github Lifecycle (Before, init, command)

we need to be carefull when using the init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/

### Working Env Vars 

#### env Command

We can list out all Enviroment variables (Env Vars) using the 'env'
command 

We can filter specific envs using rep eg. 'env | grep AWS'

#### Setting and Unsetting Env Vars 
In the terminal we can set using 'export HELLO = 'world'

In the terminal we unset using 'unset HELLO'

We can set an env var temporarly when just running a command 

```sh
HELLO = 'world' ./bin/print_message

```
Within a bash scripts we can set env without writing export eg. 
```
#!/usr/bin/env bash

HELLO='world'

echo $HELLO

```

#### Printing Vars

We can print an env using echo eg 'echo $HELLO
'

#### Scoping of Env Vars 

When you open up a new bash terminal in vscode it will not be awear of env that you have set in another window 

If you want to Env Vars to persist across all future branch teminal that are open you need to set env Vars in your bash profile . eg.'bash_profile'

#### Presisting Env Vars in Gitpod 

We can presist env vars into gitpod by stpring them in Gitpod Secrects Storage.

```
gp ev HELLO='world'
```
All future workspaces  launched will set the env vars for all bash teminals opened in thoes workspace.

you can also set env Vars  in the gitpod.yml but this can only contain non-senstive env vars.

### AWS CLI installation

AWS CLI os installes for the project via the bash scripts ['./bin/install_aws_cli'](./bin/install_aws_cli)

[Getting started install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)


['AWS CLI Env Vars'](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

we can check if our AWS credentials is configuted correctly by running the following command 

```sh
aws sts get-caller-identity
```
if it is successful you should see a json payload return that looks liks this :
```json
{
    "UserId": "AIHCEJEJDHCHDCDMMCMKCHH",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/GabrielUser"
}
```

we'll nee to generate AWS CLI credentials from IAM User in orther to the use the AWS CLI.

*************************
## Terraform Basics 

### Terraform Registry 

Terraform sources their provider and modules from  Terraform registry which is located at [registry.terraform.io](https://registry.terraform.io/) 

- **Provider** is an interface to API that will allow to create resources in terraform .
- **Modules** are a way to make large aount of terraform code modular, portble and shareable.


**************************************************************

### Terraform Console 

we can see a list of all Terraform command by simply typing `terraform`

#### Terraform init

`terraform init`

At the start of a new terraform project we will run 'terraform init ' to download the binaries for the terraform provider that we'll use in this project.

#### Terraform Plan

`terraform plan`

This will generate out a changset , about the state of our infrastucture and what will be changed.

We can output this changeset ie. "terraform plan" to passed to an apply, but often you can just ignore outptting.

#### Terraform Apply 

`terraform apply`

This will run plan and pass the changeset to be execute by terraorm . Apply should prompt yes or no .

if we want to automatically approve an apply we can provide the auto approve flag

 eg . `terraorm apply --auto-approve`

### Terraform Lock Files 

`.terrafrom.lock.hcl` 

contains the locked versioning for the provider or modulues that should be used with this project.

The Terraform lock File **should be commited** to your Version Control System (VSC) eg. Github 

### Terraform state Files 
`.terraform.tfstate` 

contain information about the current state of your infrastruture.

This file **should not be commited** to your VCS.

This file can contain sensentive data.

if you lose this file, you lose knowing the state of your infrastruture.

`.terraform.tfstate.backup` is the previous state file state.

### Terraform Directory 

`.terraform` directory contains binaries of terraform prviders.