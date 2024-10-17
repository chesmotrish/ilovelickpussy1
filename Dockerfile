# Базовый образ
FROM debian:stable-slim

# Установка необходимых пакетов
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    git \
    cmake \
    libssl-dev \
    libmicrohttpd-dev \
    libupnp-dev \
    libasound2-dev \
    libpulse-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libswscale-dev \
    libsqlite3-dev \
    libdbus-1-dev \
    libsystemd-dev \
    libudev-dev \
    libsodium-dev \
    uuid-dev \
    libqrencode-dev \
    libminiupnpc-dev \
    curl \
    pkg-config \
    gdb \
    lcov \
    wget \
    ninja-build

# Клонируем репозиторий Jami
RUN git clone https://git.jami.net/savoirfairelinux/jami-daemon.git /jami-daemon

# Переключаемся в директорию Jami Daemon
WORKDIR /jami-daemon

# Запуск компиляции с использованием Ninja вместо Make для большей скорости и совместимости
RUN cmake -G Ninja . && ninja && ninja install
