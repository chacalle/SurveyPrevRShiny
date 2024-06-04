
Install Docker https://docs.docker.com/get-docker/

The Dockerfile contains instructions for how to build the image.
The current file builds off of the [rocker images](https://rocker-project.org/) which already include important/common dependencies like shiny and geospatial analysis dependencies.


# Building and testing the image

On the development side we need to build the docker image before it can be used
```
# build the image using the Dockerfile instructions
docker build -t surveyprevrshiny:test . --platform linux/amd64

# typical start up in container with shinyapp
docker run surveyprevrshiny:test
# with 'bash' command in dockerfile start interactive command line session in container
docker run -it surveyprevrshiny:test

# push the image to the docker registry so that others can just pull use it without needing to rebuild the image
# TODO
```

# Using the image

Users will then be able to pull and run the image with the Docker Desktop app or from the command line.

It is also potentially possible to save images to disk, transfer to another computer, and load the image into docker for use. https://www.linkedin.com/pulse/how-copy-docker-image-from-one-machine-another-abhishek-rana
