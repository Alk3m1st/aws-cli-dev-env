# aws-cli-dev-env

Docker based development environment in Amazon Linux with AWS CLI, Python and other tools added

## Build the Dockerfile

`docker build -t <tag-name>:<version> .`

## Run the container

`docker container run -it <tag-name>:<version> /bin/bash`

e.g. `docker container run -it aws-dev-env:v0.2 /bin/bash`

You can now use the development environment from your terminal or connect to it with visual studio code (Use the Remote-Containers extension to attach to the running container).

If you want to mount a working directory as a volume that's straight forward also, e.g.
`docker container run -v /mnt/c/Users/user/path/to/folder/:/tmp -it aws-dev-env:v0.2 /bin/bash`
Essentially the command above mounts the absolute path on the host machine to a folder in the container storage (folder will be created if it doesn't exist already)

## List your containers

`docker ps -a`

## Remove containers once stopped

Just add the `--rm` flag when you run the container

To clean up previous containers you've exited previously
`$ docker rm $(docker ps -q -f status=exited)`

To clean up any dangling images
`$ docker rmi $(docker images -f "dangling=true" -q)`

## Set up AWS Azure Login (if your organisation federates it's AWS accounts against Azure AD)

[aws-azure-login](https://www.npmjs.com/package/aws-azure-login) NPM / Documentation
