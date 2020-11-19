import-module -name ./Set-PsEnv
Set-PsEnv # Sets .env variables as powershell's $env

$JenkinsUrl = "${env:REGISTRY_IP}:${env:JENKINS_PORT}"

write-host "Starting Jenkins and Dind..."
docker-compose up -d

write-host "Waiting for Jenkins to start..."
start-sleep 20

write-host "MyJenkins is ready. `nThe setup will ask for the password below on your first visit to: `n${JenkinsUrl}"
docker-compose exec jenkins cat '/var/jenkins_home/secrets/initialAdminPassword'
