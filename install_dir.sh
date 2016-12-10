login_ssh=docker

mkdir -p /home/apps/sabnzbd/temp
mkdir -p /home/apps/sabnzbd/complete
mkdir -p /home/apps/sabnzbd/media
chmod -Rf 777 /home/apps/sabnzbd
chown -R ${login_ssh}:${login_ssh} /home/apps/sabnzbd