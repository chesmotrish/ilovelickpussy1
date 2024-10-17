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
    curl

# Клонируем репозиторий Jami
RUN git clone https://git.jami.net/savoirfairelinux/jami-daemon.git /jami-daemon

# Компилируем и устанавливаем Jami Daemon
WORKDIR /jami-daemon
RUN cmake . && make && make install

# Запуск bootstrap ноды
ENTRYPOINT ["jami-daemon"]
