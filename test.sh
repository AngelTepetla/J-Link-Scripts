#!/bin/bash

set -e

os=`uname`

if [ "${os}" == "Linux" ]; then
  github_admin_tool_binary=github-admin-tool-linux
  install_directory=~/.local/bin
  bash_name=.bashrc
elif [ "${os}" == "Darwin" ]; then
  github_admin_tool_binary=github-admin-tool-macos
  install_directory=holi
  bash_name=.bash_profile
else
  echo Unsupported OS.
  exit 1
fi

sudo mkdir -p ${install_directory}

#chmod +x ${install_directory}/gha

#cat $HOME/${bash_name} | grep 'export PATH="$HOME/.local/bin:$PATH"' || echo 'export PATH="$HOME/.local/bin:$PATH"' >> $HOME/${bash_name}
echo Please "source ~/${bash_name}"


if [ ! -f ~/.git-credentials ]; then
    read -p "GitHub username: " APPLUSER && read -p "Personal Access Token: " APPLPAT && echo "https://$APPLUSER:$APPLPAT@github.com" >> ~/.git-credentials;
fi 

#curl -L -H "Authorization: token $(cat ~/.git-credentials | sed -n 's/^https:\/\/\(.*\):\(.*\)@github.com$/\2/p;q')" https://raw.githubusercontent.com/geappliances/applcommon.appl/master/install.sh | bash -s

##curl -s https://api.github.com/repos/geappliances/refrigeration.lighthouse-ui/releases/latest \


github_token="$(cat ~/.git-credentials | sed -n 's/^https:\/\/\(.*\):\(.*\)@github.com$/\2/p;q')"
install_directory=holi
  appl_upgrade_binary=Lighthouse-Dispenser.zip

echo $github_token

asset_urls=$(curl -s -H "Authorization: token ${github_token}" -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/geappliances/refrigeration.lighthouse-ui/releases/latest \
  | sed -n 's/"url": "\(.*assets.*\)",/\1/p')

for url in ${asset_urls}; do
  asset_name=$(curl -s -H "Authorization: token ${github_token}" -H "Accept: application/vnd.github.v3+json" ${url} \
  | sed -n 's/"name": "\(.*\)",/\1/p')

  if [ ${asset_name} == ${appl_upgrade_binary} ]; then
    #curl -L -o ${install_directory}/${appl_upgrade_binary}-temp -H "Authorization: token ${github_token}" -H "Accept: application/octet-stream" ${url}
    break
  fi
    curl -L -o ${install_directory}/${appl_upgrade_binary} -H "Authorization: token ${github_token}" -H "Accept: application/octet-stream" ${url}
done