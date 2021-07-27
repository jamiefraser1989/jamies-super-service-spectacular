$BuildPath = "H:\Development\jamies-super-service-main\"
$ProdName = "jamiesuperserviceprod"
$TestName = "jamiesuperservicetest"
$TestCmd = "docker build -t $($TestName) --target test"
$BuildCmd = "docker build -t $($ProdName)"
$RunCmd = "docker run $($ProdName)"
#Fill below variable for your Docker Hub User
$DockerHubUser = "**user**"

# Run the Test Build
Invoke-Expression -Command "$($TestCmd) $($BuildPath)"

# Test for exit code
If ($lastExitCode -eq "1") {
    Write-Host "Docket Test Failed"
    exit
}
If ($lastExitCode -eq "0") {
    Write-Host "Success !! - Time to build the release"
}
# Build for release (Deployed to local images on Docker Desktop)
Invoke-Expression -Command "$($BuildCmd) $($BuildPath)"

# Push image to Docker Hub - Uncomment below if you want to run this
#Invoke-Expression -Command "docker push $($DockerHubUser)/$($ProdName):latest"

# Run container (Local container Docker Desktop) - Uncomment below if you want to run this
#Invoke-Expression -Command "$($RunCmd)"
