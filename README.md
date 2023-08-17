
# CI/CD Inference Pipeline: Using Git, Flask, Terraform, Cloud, Github Actions and Docker

## Overview

Main objective of this project is to serve a machine learning inference service implemented using modern CI/CD techniques. By CI/CD we infer Continuous Integration and Continuous Deployment/Delivery eventually contributing to smooth and continuous development of software (application or a product).

In this project simple machine learning model is used to infer over a REST API call using very naive(due to less records) dataset. Github is used for version control of our codebase for continuous development iterations and Flask is used as pythonic framework to wrap ML service into a REST API. Terraform is used as a provisioning platform to provision resources like compute (Virtual Machine) or Storage etc. Cloud (Any of Azure, AWS, GCP, DigitalOcean etc.) is used to get these resources as per usage model. Finally Github Actions (Runner) is used to set up a workflow for our installation, build, deploy and test.(all done on provisioned resource)

## Git, Flask, Terraform, Cloud, Github Actions & Docker: Brief Intro

**Git:** For version control of codebase so that parallel development of any application/software is possible by multiple individual contributors. [For more details refer.](https://git-scm.com/)

**Flask:** Popular Framework in Python (apart from Django,Fast API) used to wrap any service into a REST API service. [For more details refer.](https://flask.palletsprojects.com/en/2.3.x/)

**Terraform:** Iaac (Infrastructure as a code) platform which provisions resources from available cloud service providers based on param request in the form of JSON like language called HCL (HashiCorp Configuration Language).[For more details refer.](www.terraform.io)

**Cloud:** Azure, AWS, GCP, DigitalOcean, Alibaba etc. are some cloud providers that provide resources for computations, storage or any other services like data pipeline, worklows, inbuilt AI/ML etc. [For more details refer.](https://azure.microsoft.com/en-us/)

**Note:** *Azure is used in this project for provisioning Virtual Machine for compute.*

**Github Actions:** The most important aspect of this CI/CD project is github actions for serving as a workflow manager and actor to use resources provisioned and invoke build, test and deploy features. (all done basically just by a YAML workflow file) [For more details refer.](https://docs.github.com/en/actions)

**Docker:** Guilty of being the most famous contaninerized software platform/tool to package everything from dependency to codebase and even runtime. [For more details refer.](www.docker.com)

## Machine Learning Inference Service: Details

Using a simple structured dataset (named iris) a model is trained (decision tree) on historical dataset of iris plant types. The data set contains 3 classes, where each class refers to a type of iris plant and features on which model is trained are attributes like dimensions of parts. For more details over dataset one can refer the dataset under *data/input/train* directory. (will not go deep into ML here)
In simple words model is trained on train data and inference is done(means plant type of iris is given as output) by the model when features/attributes are passed to it.
Eventually this is packaged and served as REST API.(Refer *code* directory)

## Prerequisites

1. Create a github repository or clone this one.
2. Get some credits of Cloud (Azure) mostly a free trial is enough for some time.
3. Install Terraform on local. [Refer](terraform.io)
4. If using this repo's dockerfile then local installation of docker can be avoided but it is advised to install Docker desktop client for long run.

## Steps in CI/CD

1. There are four jobs for this project: install (this is only for docker installlation on resource), build, deploy and test
2. All jobs are listed in the YAML file in *.github/workflows* directory with respective order.
3. We have our ML code packaged in a Dockerfile which is used by the github action workflow to create image(build) and deploy on self-hosted Azure VM resource provisioned via terraform.
4. Refer *terraform* directory for *main.tf* HCL script which provisons a virtual machine. (mainly three steps: *terraform init, terraform plan, terraform apply*)
**Note:** Here get public key of your local machine (Linux/Windows/Mac) so that you can SSH into the VM remotely and make it suitable for Github Actions to host our computations.[Refer](https://www.howtogeek.com/762863/how-to-generate-ssh-keys-in-windows-10-and-windows-11/)

5. After provisioning of Azure VM, login to Azure portal and note Public IP as well as enable identity as System Managed.
6. Note that here github workflow yaml file (*docker-image.yml*) we can use any github hosted machine but in that case we will not be able to use same resource across various jobs. (hence using self-hosted machine: Azure VM)
7. SSH into the VM (ssh user@ip)
8. After that add a runner from github and follow the steps given in the next prompt (keep in mind their is time limited token for this) in the VM. Basically this installs a github-VM communication client.
[Refer](https://cloudwithchris.medium.com/using-the-github-self-hosted-runner-and-azure-virtual-machines-to-login-with-a-system-assigned-8676f0406122)

9. Now after ./run.sh is executed VM will be ready to listen to any incoming requests/jobs submitted by github actions once event is triggered. Here event we have kept as any push or PR to master branch, meaning any change accepted in master branch will invoke all the steps install docker, build/deploy and test.
10. One can check the inference also by submitting a POST request to below url: (here port is hardcoded to 6666 but it can be user defined as well)
`http://ip:port/inference`  with payload `[{"0":0,"1":5,"2":7,"3":6},{"0":1,"1":3,"2":3,"3":1}]` and the deployed inference service will give respective iris plant predictions.(2 predictions for 2 records)

**Note:** If using this repo's workflow file then note IP is taken from github's repository env variable so developer may need to substitute or add IP in repository variable section.

## Summary

* Wrapped a machine learning inference service as a REST call.
* Just mere push to master branch of the repository invokes the build, test and deploy steps automatically.
* Hence obtaining CI/CD for this sample ML use case.
* Docker is used as a contaierized tool hence there is a scope for using scaled set of VMs or even an orchestator like kubernetes.(Stay tuned :)

      ==End of Document==
