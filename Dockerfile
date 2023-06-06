FROM nimmis/ubuntu:20.04

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
    apt install -y curl wget dirmngr gnupg lsb-release gnupg && \
    curl -fsSL https://pgp.mongodb.com/server-6.0.pub | gpg --dearmor -o /usr/share/keyrings/mongodb-server-6.0.gpg && \
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt update && apt-get clean && \
    useradd -m -G sudo -s /bin/bash tactical
