login_ssh="docker"

service ssh start > /home/${login_ssh}/services.log
service apache2 start > /home/${login_ssh}/services.log
sabnzbdplus >> /home/${login_ssh}/services.log
chmod -f 777 /home/${login_ssh}/services.log