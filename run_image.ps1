$RegistryIp = "192.168.1.151"
$RegistryPort = "5000"
$Tag = "myjenkins-blueocean:1.1"
$JenkinsPort = 8080

$AddressedTag = "${RegistryIp}:${RegistryPort}/${Tag}"

write-host "Create docker network jenkins..."
docker `
  network `
  create `
  jenkins

write-host "Pull and Run docker-in-docker image..."
docker run `
  --name jenkins-docker `
  --rm `
  --detach `
  --privileged `
  --network jenkins `
  --network-alias docker `
  --env DOCKER_TLS_CERTDIR=/certs `
  --volume jenkins-docker-certs:/certs/client `
  --volume jenkins-data:/var/jenkins_home docker:dind

write-host "Pull and Run MyJenkins image..."
docker run `
  --name jenkins-blueocean `
  --rm `
  --detach `
  --network jenkins `
  --env DOCKER_HOST=tcp://docker:2376 `
  --env DOCKER_CERT_PATH=/certs/client `
  --env DOCKER_TLS_VERIFY=1 `
  --volume jenkins-data:/var/jenkins_home `
  --volume jenkins-docker-certs:/certs/client:ro `
  --publish "${JenkinsPort}:8080" `
  --publish 50000:50000 "$AddressedTag"

write-host "Waiting for Jenkins to start..."
start-sleep 20

write-host "MyJenkins is ready. `nThe setup will ask for the password below on your first visit to: ${RegistryIp}:${JenkinsPort}"
docker exec -it jenkins-blueocean cat '/var/jenkins_home/secrets/initialAdminPassword'
