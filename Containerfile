FROM ubuntu:noble

RUN apt-get update

RUN apt-get install -y software-properties-common sqlite3

RUN dpkg --add-architecture i386

RUN add-apt-repository multiverse

RUN echo steam steam/question select "I AGREE" | debconf-set-selections

RUN apt-get install -y steamcmd lib32gcc-s1

RUN apt-get clean

RUN /usr/games/steamcmd +force_install_dir /opt/pz +login anonymous +app_update 380870 validate +quit

RUN useradd -m pz

USER pz

RUN mkdir -p /home/pz/Zomboid/Server

WORKDIR /home/pz/Zomboid/db

ADD servertest.ini

ADD servertest_SandboxVars.lua

RUN mkdir -p /home/pz/Zomboid/db

WORKDIR /home/pz/Zomboid/db

ADD servertest.db.sql

RUN sqlite3 servertest.db < servertest.db.sql

RUN rm servertest.db.sql

WORKDIR /home/pz

CMD exec /opt/pz/start-server.sh
