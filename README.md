## What is this project?
This is a Terraform Infrastructure-as-Code implementation of the following tutorial: https://testdriven.io/blog/django-azure-app-service/  
The purpose of the project is to replicate the steps of the tutorial (without the last, custom domain step) and deploy a Django web application with a PostgreSQL database to Azure with minimal required user interaction.

## How to use this project?
Prerequisites: installed Terraform CLI, Azure account, setup Azure service principal for Terraform.  
First, clone the repository to your local machine. The code doesn't contain sensitive data (PostgreSQL username/password, Django application secret key), you need to generate and add those to the Terraform code before apply it. One way for this is creating a 'secret.tfvars' file, excluding it from version control and adding the required secrets to it in key-value pairs.  

```hcl
SECRET_KEY        = "django-app-unsafe-secret-key"  
DB_ADMIN_USER     = "postgresql-db-username"  
DB_ADMIN_PASSWORD = "postgresql-db-unsafe-password"  
```  

You can start the deployment with Terraform using the given secret variables with the following command:  

```sh
terraform apply -var-file="secret.tfvars"
```
  
Terraform will create multiple resources and sets them up:
- Creates an Azure Web Service, pulls the application code from GitHub and deploys it
- Creates a PostgreSQL Flexible Server
- Creates a persistent blob storage to store images and static files
- Sets up networking and communication between the resources
  
The creation of the resources takes approximately 5 minutes. After that, the deployed application needs an additional 1-2 minutes to pull and install its dependencies. When it's ready, the database of the application needs to be migrated to the newly created PostgreSQL database. For this, the user needs to establish an SSH connection to the web app and type some commands to execute the migration. On the Azure console, navigate to the created App Service, select the Development Tools/SSH tab from the sidebar. 
Type in these commands:

```sh
python manage.py migrate
python manage.py createsuperuser
```

This will migrate the database and creates a new superuser.

After these setups, the app should run without error. The URL is given at the output of the Terraform deployment or can be checked in the Azure console, on the App Service resource.
