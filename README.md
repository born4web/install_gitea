# Gitea server easy install 

Use these scripts to automate and ease of installation popular git server Gitea on Linux Ubuntu. 
Gitea can run on different kind of databases so choose the right script according your database demand.

Installation is as close as possible to official Gitea doccumentation recommendations (directory locations, permissions, ownerships,...).

For any installation script you will need bash_script_library.sh also, because it has some helpfull piece of code I use.

Best way to use it is to git clone this repository inside your home directory and then make choosen script executable and run installation... 

1. SQLite - install_gitea_sqlite_download_gitea.sh
- tries to download gitea from their website
- this option expects to setup demanded gitea version inside of setup_gitea_demanded_version.sh script
- finish install through web interface (http://ip_of_yur_gitea:3000/install) and choose SQLite as your database for Gitea

2. SQLite - install_gitea_sqlite_homedir_gitea.sh
- I experienced many times very slow response from Gitea web during download and many times downloads even restarting several times. 
So I made another script which expects having Gitea downloaded in advance
- rename which ever binary version of Gitea downloaded in advance and copy it in your home directory root
- finish install through web interface (http://ip_of_yur_gitea:3000/install) and choose SQLite as your database for Gitea

   





--------------------------------------------------
Thanks to https://linuxize.com/post/how-to-install-gitea-on-ubuntu-18-04/ for good working
manual for step by step installation process. I used those steps to build this scripts just 
because I am lazy to do it more then once manually.


