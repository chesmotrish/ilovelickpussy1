# Используем базовый образ Ubuntu 20.04
FROM ubuntu:20.04

# Обновляем систему и устанавливаем curl и необходимые зависимости для управления репозиториями
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    ca-certificates \
    software-properties-common

# Добавляем Jami репозиторий и ключ
RUN curl -fsSL https://dl.jami.net/nightly/ubuntu_20.04/jami.asc | tee /usr/share/keyrings/jami.asc.gpg > /dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/jami.asc.gpg] https://dl.jami.net/nightly/ubuntu_20.04/ ring main" | tee /etc/apt/sources.list.d/jami.list > /dev/null

# Повторное обновление списка пакетов после добавления нового репозитория
RUN apt-get update

# Установка jami-daemon с опцией для решения возможных конфликтов
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends jami-daemon

# Очищаем apt cache для уменьшения размера образа
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Открываем необходимый порт для Jami bootstrap сервера
EXPOSE 4222

# Запуск Jami bootstrap сервера
CMD ["jami-daemon"]
