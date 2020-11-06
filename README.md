# aws-cli-dev-env

Docker based development environment in Amazon Linux with AWS CLI, Python and other tools added

## Build the Dockerfile

`docker build -t <tag-name>:<version> .`

## Run the container

`docker container run -it <tag-name>:<version> /bin/bash`

e.g. `docker container run -it aws-dev-env:v0.2 /bin/bash`
