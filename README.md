# MyJenkins

Jenkins setup repo for home use. This repo assumes the following:

1. The host computer runs windows
2. The guest computer that creates the jenkins image runs a debian linux version
3. The host runs the private docker repository "registry:2" at port 5000
4. That the registry is set as an `insecure-registry` by the docker instances of
   the host and the client

## Current settings

Current settings are listed here for convenience. These values are not defined
in a single file such as `.env` as this is a very small repo and changing these
manually is no hassle.

- Jenkins image: `jenkins/jenkins:2.249.3-slim`
- Host ip (registry ip): `192.168.1.151`
- Registry port: `5000`
- Image tag: `myjenkins-blueocean:1.1`
- Jenkins port: `8080`

## Usage

### Creating, pushing the image to the registry

`./create_push_image.sh` is intended to do the following:

1. Pull the jenkins image
2. build the image as recommended by the
   [Jenkins Docker guide](https://www.jenkins.io/doc/book/installing/docker/)
3. Tags it with the repository address
4. Pushes the custom image

### Running the Jenkins container on the host

`./run_image.ps1` is intended to do the following:

1. Pull the MyJenkins image from the private repo
2. Create the network `jenkins`
3. Create the docker-in-docker container instance
4. Create the MyJenkins instance
5. Return the jenkins startup admin password along with the url that the user
   shall visit

### Using jenkins

Jenkins instance shall be available at: `<Host ip>:<Jenkins port>`. Once the
`./run_image.ps1` is run on the host machine, it will return the initial admin
password to continue the setup.

Setup and operation of Jenkins after said stage is beyond the scope of this
repo.
