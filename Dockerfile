# Используем базовый образ Ubuntu
FROM ubuntu:20.04

# Устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    qtbase5-dev \
    qttools5-dev-tools \
    qtdeclarative5-dev \
    libqt5svg5-dev \
    libprotobuf-dev \
    protobuf-compiler \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libboost-all-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Клонируем репозиторий Jami
RUN git clone https://git.jami.net/savoirfairelinux/jami-daemon.git /jami-daemon

# Переход в директорию проекта
WORKDIR /jami-daemon

# Сборка проекта
RUN mkdir build && cd build && cmake .. && make

# Открываем порт для Jami bootstrap сервера
EXPOSE 4222

# Запуск Jami bootstrap сервера
CMD ["./build/jami-daemon"]
