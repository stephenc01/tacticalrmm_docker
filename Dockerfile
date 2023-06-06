FROM nimmis/ubuntu:20.04

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
    apt install -y curl wget dirmngr gnupg lsb-release gnupg && \
    curl -fsSL https://pgp.mongodb.com/server-6.0.pub | gpg --dearmor -o /usr/share/keyrings/mongodb-server-6.0.gpg && \
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt update && apt-get clean && \
    curl -o /install.sh https://raw.githubusercontent.com/amidaware/tacticalrmm/master/install.sh && \
    curl -o /backup.sh https://raw.githubusercontent.com/amidaware/tacticalrmm/master/backup.sh && \
    curl -o /restore.sh https://raw.githubusercontent.com/amidaware/tacticalrmm/master/restore.sh && \
    curl -o /update.sh https://raw.githubusercontent.com/amidaware/tacticalrmm/master/update.sh && \
    useradd -m -G sudo -s /bin/bash tactical
