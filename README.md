# azure-snyk
A docker image that can be used with Azure DevOps to perform snyk scans.  The images provided by Snyk are based on a
container that's too slim to run in Azure DevOps.

If you want to use it you can do something like this in your ``azure-pipelines.yml``...

````
jobs:
    - job: SnykTest
      pool:
        vmImage: 'ubuntu-16.04'
      container: kunai/azure-snyk:latest
      steps:
        - script: snyk auth $SNYK_KEY
        - script: snyk test
````
