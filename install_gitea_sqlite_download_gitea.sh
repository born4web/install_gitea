#!/bin/bash

# Gitea demanded version
. setup_gitea_demanded_version.sh
# library with help scripts
. ./bash_script_library.sh

echo "
-------------------------------------------
*     Checking Gitea demanded version     *
-------------------------------------------
"
if [[ $gitea_version == "" ]]; then
    echo "Error: Gitea version not defined in gitea_demanded_version.sh exiting..."
    exit 1
else
    echo "I will install version : ${gitea_version}"
fi

echo "
--------------------------------------
*       System update/upgrade        *
--------------------------------------
"
error_code=$(sudo apt-get update)
echo "Error code: $error_code"
if $error_code
then
    echo "
    Error: 'apt-get update' Update did not run correctly\\
"
    exit 1
fi


echo "
-------------------------------
*     sqlite installation     *
-------------------------------
"
sudo apt install sqlite3


echo "
----------------------------
*     git installation     *
----------------------------
"
sudo apt install git

echo "
--------------------------------------------
*     add system user git to run gitea     *
--------------------------------------------
"
# create git user
sudo adduser --system --group --disabled-password --shell /bin/bash --home /home/git --gecos 'Git Version Control' git

echo "
--------------------------------------
*     download and install gitea     *
--------------------------------------
"
sudo wget -O /tmp/gitea https://dl.gitea.io/gitea/${gitea_version}/gitea-${gitea_version}-linux-amd64
sudo mv /tmp/gitea /usr/local/bin
sudo chmod +x /usr/local/bin/gitea
sudo mkdir -p /var/lib/gitea/{custom,data,indexers,public,log}
sudo chown git: /var/lib/gitea/{data,indexers,log}
sudo chmod 750 /var/lib/gitea/{data,indexers,log}
sudo mkdir /etc/gitea
sudo chown root:git /etc/gitea
sudo chmod 770 /etc/gitea

echo "
-------------------------------------------
*     gitea daemon recommended setup      *
-------------------------------------------
"
sudo wget https://raw.githubusercontent.com/go-gitea/gitea/master/contrib/systemd/gitea.service -P /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now gitea

echo "
----------------------------------------
*     gitea installation done OK       *
----------------------------------------
"

