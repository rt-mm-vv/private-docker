FROM node:12.4

RUN npm install -g @aws-amplify/cli

# Amplify mock のために java インストール（AdoptOpenJDK 11）
RUN apt update; apt install -y wget software-properties-common apt-transport-https gnupg
RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add -
RUN add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
RUN apt update; apt install -y adoptopenjdk-11-openj9

WORKDIR /var/www/todo