# Jamies Super Service DevOps Task

Here is my Super Service, I hope you enjoy!

## Testing / Building / Deploying - Locally

Make sure to have Docker Desktop installed on your PC
Clone the Git repo into your system or if you don't have git just download the archive and unzip into a folder.

Edit the **Automate.ps1** file:

 - Change $BuildPath to the parent directory
 - If using Docker Hub edit the variable for $DockerHubUser and
   uncomment the **Push image to Docker Hub** section
 - If you want to run the container straight away uncomment the last section.
 - More can be added to deploy to the cloud e.g. Azure (Azure environment will need to be set up prior to this):
	 - Make sure container registry exist
	 - Tag image with full login server name e.g. 
		 - `docker tag $($ProdName) <acrLoginServer>/$($ProdName):v1.0.0`
	 - Make sure Azure CLI is installed on PC
	 - The run something like:
		 - `az container create --resource-group resourceGroupName --name $($ProdName) --image <acrLoginServer>/$($ProdName):v1.0.0 --dns-name-label <uniqueLabel> --ports 80`

## Testing / Building / Deploying - GitHub Actions

There is a workflow file set up for GitHub actions to test, build the push the image to DockerHub automatically after every push on the repository.  It will test the unit test first before building the image and cancel the build if it fails.  If it passes, the build will be pushed to Docker Hub.  Again this can be edited further to deploy to cloud based services.
File location: **.github/workflows/docker-publish.yaml

## Extras
I combined the projects into one solution, just to make it simple.

**Potential improvements going forward:**
 - Have unit testing to be carried out once WebApi is running from external connection, to test networking and functionality.
 - Should have had full Azure set up to test full deployment to cloud.  Allow for all secrets to be stored in GitHub.

