FROM perl:latest

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y cpanminus && \
    cpanm -n App::LastStats@0.0.9

