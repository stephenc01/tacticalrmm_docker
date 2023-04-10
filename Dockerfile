# syntax=docker/dockerfile:1
FROM nimmis/ubuntu:20.04
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN apt install -y curl wget dirmngr gnupg lsb-release gnupg
RUN curl -fsSL https://pgp.mongodb.com/server-6.0.pub | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-6.0.gpgRUN touch /etc/apt/sources.list.d/mongodb-org-6.0.list
RUN echo "deb [ arch=amd64,arm64 signed=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
RUN sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
RUN apt update
RUN apt-get clean
RUN useradd -m -G sudo -s /bin/bash tactical
