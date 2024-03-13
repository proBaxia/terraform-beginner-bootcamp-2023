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