#!/bin/bash
echo "Starting Installation of erdlet's Pop_OS system..."
echo ""

echo "###################################"
echo "# Running system update...        #"
echo "###################################"
sudo apt update && sudo apt upgrade -y
echo "###################################"
echo "# Finished system update...       #"
echo "###################################"
echo ""
echo "###################################"
echo "# Creating directory structure... #"
echo "###################################"
echo ""
directories=("Applications" "Development/github" ".ssh")
for dir in ${directories[@]}; do
	dirPath="$HOME/$dir"
	mkdir -p "$dirPath"
	if [ $? -ne 0 ]; then
		echo "Failed to create $dirPath"
	else
		echo "$dirPath created"
	fi
done

echo ""
echo "########################################"
echo "# Finished directory structure...      #"
echo "########################################"
echo ""

echo ""
echo "########################################"
echo "# Starting application installation... #"
echo "########################################"
echo ""

sudo apt install \
	thunderbird \
	postgresql \
	postgresql-contrib \
	zulucrypt-gui -y 

flatpak install flathub com.bitwarden.desktop -y

echo ""
echo "########################################"
echo "# Finished application installation... #"
echo "########################################"
echo ""

echo ""
echo "########################################"
echo "# Start to move config files...        #"
echo "########################################"
echo ""
currentDir="$(pwd)"

homeFiles=(".XCompose" ".bashrc" ".gitconfig" ".gitignore_global")
for hf in ${homeFiles[@]}; do
	cp "$currentDir/$hf" "$HOME"
	if [ $? -eq 0 ]; then
		echo "Moved $hf to $HOME"
	else
		echo "Failed to move $hf to $HOME"
	fi
done

echo ""
echo "###########################################"
echo "# Finished to move config files...        #"
echo "###########################################"
echo ""

echo ""
echo "########################################"
echo "# Install NodeJS and pnpm...           #"
echo "########################################"
echo ""
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Download and install Node.js:
nvm install 22

# Verify the Node.js version:
node -v # Should print "v22.13.0".
nvm current # Should print "v22.13.0".

# Download and install pnpm:
corepack enable pnpm

# Verify pnpm version:
pnpm -v

echo ""
echo "############################################"
echo "# Finished NodeJS and pnpm installation... #"
echo "############################################"
echo ""

echo ""
echo "############################################"
echo "# Starting SDKMan installation...          #"
echo "############################################"
echo ""

curl -s "https://get.sdkman.io" | bash

source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install java 21-tem

echo ""
echo "############################################"
echo "# Finished SDKMan installation...          #"
echo "############################################"
echo ""
