# Используем базовый образ Ubuntu
FROM ubuntu:20.04

# Устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    dirmngr \
    lsb-release \
    software-properties-common && \
    rm -rf /var/lib/apt/lists/*

# Добавляем ключи и репозиторий Jami
RUN curl -fsSL https://dl.jami.net/nightly/ubuntu_20.04/jami.asc -o jami.asc && \
    gpg --dearmor -o /usr/share/keyrings/jami.gpg jami.asc && \
    echo "deb [signed-by=/usr/share/keyrings/jami.gpg] https://dl.jami.net/nightly/ubuntu_20.04/ ring main" > /etc/apt/sources.list.d/jami.list && \
    rm jami.asc

# Обновляем список пакетов и устанавливаем jami-daemon
RUN apt-get update && apt-get install -y jami-daemon && rm -rf /var/lib/apt/lists/*

# Открываем порт для Jami bootstrap сервера
EXPOSE 4222

# Запуск Jami bootstrap сервера
CMD ["jami-daemon"]
