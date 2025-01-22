FROM ubuntu:24.04

RUN apt update && apt install -y \
    build-essential \
    curl \
    git \
    gnupg \
    make \
    rsync \
    zip \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:rabbitmq/rabbitmq-erlang && \
    apt update && apt install -y elixir erlang && rm -rf /var/lib/apt/lists/*

