# Используем базовый образ Ubuntu
FROM ubuntu:20.04

# Обновляем систему и устанавливаем необходимые зависимости для добавления репозиториев
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    ca-certificates \
    software-properties-common

# Добавляем Jami репозиторий и ключи
RUN echo "deb [signed-by=/usr/share/keyrings/jami.asc.gpg] https://dl.jami.net/nightly/ubuntu_20.04/ ring main" | tee /etc/apt/sources.list.d/jami.list > /dev/null \
    && curl -fsSL https://dl.jami.net/nightly/ubuntu_20.04/jami.asc | tee /usr/share/keyrings/jami.asc.gpg > /dev/null

# Обновляем список пакетов и устанавливаем jami-daemon
RUN apt-get update && apt-get install -y jami-daemon

# Открываем необходимый порт для Jami bootstrap сервера
EXPOSE 4222

# Запуск Jami bootstrap сервера
CMD ["jami-daemon"]
