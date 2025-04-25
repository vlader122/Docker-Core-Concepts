#!/bin/bash

# Exercise 1
echo "=== Exercise 1 ==="
echo "1. Installing Docker Engine..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "2. Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

echo "3. Printing Docker info..."
docker info

# Exercise 2
echo -e "\n=== Exercise 2 ==="
echo "1. Searching for official repos..."
docker search --limit "is-official=true" ubuntu
docker search --limit "is-official=true" alpine
docker search --limit "is-official=true" nginx

echo "2. Running Nginx container..."
docker run -d --name nginx_niver -p 8080:80 nginx
sleep 5  # Give container time to start

# Exercise 3
echo -e "\n=== Exercise 3 ==="
echo "1. Checking Docker daemon status..."
sudo systemctl status docker --no-pager

echo "2. Stopping Docker daemon..."
sudo systemctl stop docker

echo "3. Trying to run container while daemon is stopped..."
docker run hello-world || echo "As expected, cannot run containers when daemon is stopped"

echo "4. Restarting Docker daemon and running container..."
sudo systemctl start docker
docker run --rm hello-world

# Exercise 4
echo -e "\n=== Exercise 4 ==="
echo "1. Running Ubuntu container interactively..."
docker run -it --name ubuntu_niver ubuntu bash -c "echo 'Running commands in container...'; apt-get update && apt-get install -y curl; echo 'Installed curl:'; curl --version; exit"
docker rm ubuntu_niver

# Exercise 5
echo -e "\n=== Exercise 5 ==="
echo "1. Listing running containers:"
docker ps

echo "2. Listing all containers (including exited):"
docker ps -a

# Exercise 6
echo -e "\n=== Exercise 6 ==="
echo "1. Running container in background..."
docker run -d --name backgroud_exercise nginx

echo "2. Pausing container..."
docker pause backgroud_exercise
docker ps

echo "3. Unpausing container..."
docker unpause backgroud_exercise
docker ps

echo "4. Stopping container..."
docker stop backgroud_exercise
docker ps -a

echo "5. Restarting container..."
docker restart backgroud_exercise
docker ps

echo "6. Killing container..."
docker kill backgroud_exercise
docker ps -a
docker rm backgroud_exercise

# Exercise 7
echo -e "\n=== Exercise 7 ==="
echo "Removing a running container..."
docker run -d --name remove_me nginx
docker rm -f remove_me

# Exercise 8
echo -e "\n=== Exercise 8 ==="
echo "1. Pulling alpine and ubuntu images..."
docker pull alpine
docker pull ubuntu

echo "2. Listing all container images..."
docker images

# Exercise 9
echo -e "\n=== Exercise 9 ==="
echo "1. Running alpine and executing command..."
docker run alpine echo "hello from alpine"

echo "2. Running busybox and executing command..."
docker run busybox uname -a

echo "3. Listing all containers..."
docker ps -a

# Exercise 10
echo -e "\n=== Exercise 10 ==="
echo "1. Removing all stopped containers..."
docker container prune -f

echo "2. Removing unused images..."
docker image prune -af

echo "3. Inspecting Docker disk usage..."
docker system df

echo -e "\n=== All exercises completed! ==="