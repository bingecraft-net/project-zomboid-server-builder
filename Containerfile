FROM ubuntu:noble

RUN apt-get update

RUN apt-get install -y software-properties-common

RUN dpkg --add-architecture i386

RUN add-apt-repository multiverse

RUN echo steam steam/question select "I AGREE" | debconf-set-selections

RUN apt-get install -y steamcmd lib32gcc-s1
