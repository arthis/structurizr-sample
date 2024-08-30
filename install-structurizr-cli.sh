#!/bin/bash

#make sure is running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

input_variable="$(pwd)"

echo "C4 model root path: $input_variable"

# Download the latest version of the Structurizr CLI
docker pull structurizr/cli:latest

#if structurizr file exists, remove it
if [ -f structurizr ]; then
    rm structurizr
fi

# Create a structurizr file that runs the Structurizr CLI docker 
echo "creating structurizr file..."
echo "#!/bin/bash" > structurizr
echo "docker run --rm -v $input_variable:/workspace structurizr/cli:latest \$@" >> structurizr

#create a symbolic link to the structurizr file
chmod +x structurizr
# if symbolic link exists then removes it
if [ -f /usr/local/bin/structurizr ]; then
    echo "removing structurizr symbolic link..."
    sudo rm /usr/local/bin/structurizr
fi
sudo ln -s $(pwd)/structurizr /usr/local/bin/structurizr


sudo apt update
sudo apt install inotify-tools
