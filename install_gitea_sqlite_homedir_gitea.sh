#!/bin/bash

# library with help scripts
. ./bash_script_library.sh

echo "
-------------------------------------------------------------------------
*     Do you have gitea binary file in root of your home directory?     *
-------------------------------------------------------------------------
"
volba=yes_or_no
if $volba
then
    echo "
    -------------------------------------
    *     Using existing gitea file     *
    -------------------------------------
    "
else
    echo "
    ---------------------------------------------------------------
    *     OK copy gitea there. I close installation for now..     *
    ---------------------------------------------------------------
    "
    exit 2
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
sudo mv ~/gitea /usr/local/bin
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

