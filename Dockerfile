# syntax=docker/dockerfile:1
FROM nimmis/ubuntu:20.04
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN apt install -y curl wget dirmngr gnupg lsb-release
RUN apt-get clean
RUN useradd -m -G sudo -s /bin/bash tactical
