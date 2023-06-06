FROM nimmis/ubuntu:20.04

ENV PYTHON_VER='3.11.3'
ENV numprocs=$(nproc)

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
    apt install -y gnupg gnupg-agent && \
    gpg-connect-agent reloadagent /bye && \
    curl -fsSL https://pgp.mongodb.com/server-6.0.pub | gpg --dearmor -o /usr/share/keyrings/mongodb-server-6.0.gpg && \
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt install -y curl wget dirmngr lsb-release gnupg software-properties-common certbot openssl nginx gcc g++ make build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev libbz2-dev ca-certificates redis git postgresql-14 && \
    apt update && apt install -y nodejs mongodb-org && npm install -g npm && \
    apt-get clean && \
    wget https://www.python.org/ftp/python/${PYTHON_VER}/Python-${PYTHON_VER}.tgz && \
    tar -xf Python-${PYTHON_VER}.tgz && \
    cd Python-${PYTHON_VER} && \
    ./configure --enable-optimizations && \
    make -j $numprocs && \
    make install && \
    cd ~ && \
    rm -rf Python-${PYTHON_VER} Python-${PYTHON_VER}.tgz && \
    curl -o /install.sh https://raw.githubusercontent.com/amidaware/tacticalrmm/master/install.sh && \
    curl -o /backup.sh https://raw.githubusercontent.com/amidaware/tacticalrmm/master/backup.sh && \
    curl -o /restore.sh https://raw.githubusercontent.com/amidaware/tacticalrmm/master/restore.sh && \
    curl -o /update.sh https://raw.githubusercontent.com/amidaware/tacticalrmm/master/update.sh && \
    chmod +x /install.sh /backup.sh /restore.sh /update.sh && \
    useradd -m -G sudo -s /bin/bash tactical
