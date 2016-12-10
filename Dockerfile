# Sabnzbd dans un container
#
# VERSION               0.0.1
#

FROM     ubuntu:yakkety
MAINTAINER Fwedoz "fwedoz@gmail.com"

# Definition des constantes
ENV login_ssh="docker"
ENV password_ssh="docker"

# Mise a jour des depots
RUN (apt-get update && apt-get upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)

# Ajout des depots necessaires
RUN apt-get install -y -q wget nano git zip openssh-server php7.0 sabnzbdplus python-glade2

# Ajout utilisateur "${login_ssh}"
RUN adduser --quiet --disabled-password --shell /bin/bash --home /home/${login_ssh} --gecos "User" ${login_ssh}

# Modification du mot de passe pour "${login_ssh}"
RUN echo "${login_ssh}:${password_ssh}" | chpasswd

# Configuration de SabNzbd
RUN rm -f /etc/default/sabnzbdplus
COPY sabnzbdplus /etc/default/sabnzbdplus
RUN rm -f /root/.sabnzbd/sabnzbd.ini
COPY sabnzbd.ini /root/.sabnzbd/sabnzbd.ini

# Configuration des dossiers
COPY install_dir.sh /root/install_dir.sh
RUN chmod -f 755 /root/install_dir.sh
RUN sh /root/install_dir.sh

# Ajout du script services.sh au demarrage
COPY services.sh /root/services.sh
RUN chmod -f 755 /root/services.sh
RUN echo "sh /root/services.sh" >> /root/.bashrc

# Ports
EXPOSE 22 80 7878 8080

# Point de montage
VOLUME ["/home"]
