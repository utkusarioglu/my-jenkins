# MyJenkins

Jenkins setup repo for home use. This repo assumes the following:

1. The host computer runs windows
2. The guest computer that creates the jenkins image runs a debian linux version
3. The host runs the private docker registry image `registry:2` at port `5000`
4. That the registry is set as an `insecure-registry` by the docker instances of
   the host and the client

## Current settings

Current settings can be found in the .env file. Bash, Docker and Powershell
scripts all read these values. The PowerShell .env parser was taken from
[here](https://gist.github.com/grenzi/82e6cb8215cc47879fdf3a8a4768ec09#file-set-psenv-psm1)

## Usage

### Creating, pushing the image to the registry

`./create_push_image.sh` is intended to do the following:

1. Pull the jenkins image
2. build the image as recommended by the
   [Jenkins Docker guide](https://www.jenkins.io/doc/book/installing/docker/)
3. Tags it with the repository address
4. Pushes the custom image

### Initializing Jenkins on the host machine

`./init.ps1` is intended initialize the jenkins network, start the containers
and finally return the initial admin password for jenkins. Jenkins instance
shall be available at: `<REGISTRY_IP>:<JENKINS_PORT>`.

Setup of Jenkins after this stage is beyond the scope of this repo.

### Subsequent runs of Jenkins on the host

After the initalization, Jenkins containers can be started by simply using
`docker-compose up`.
