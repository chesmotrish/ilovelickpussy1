FROM ubuntu:20.04

# Установка необходимых пакетов
RUN apt-get update && apt-get install -y \
    jami-daemon \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Конфигурация bootstrap сервера
COPY bootstrap.conf /etc/jami/bootstrap.conf

# Открытие порта для соединений
EXPOSE 4222

# Запуск сервера
CMD ["jami-daemon", "-c", "/etc/jami/bootstrap.conf"]
