# Используем базовый образ Ubuntu
FROM ubuntu:20.04

# Обновляем систему и устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    ca-certificates \
    software-properties-common

# Добавляем репозиторий Jami
RUN echo "deb [signed-by=/usr/share/keyrings/jami.asc.gpg] https://dl.jami.net/nightly/ubuntu_20.04/ ring main" | tee /etc/apt/sources.list.d/jami.list > /dev/null && \
    curl -fsSL https://dl.jami.net/nightly/ubuntu_20.04/jami.asc | tee /usr/share/keyrings/jami.asc.gpg > /dev/null

# Устанавливаем Jami Daemon (серверную часть)
RUN apt-get update && apt-get install -y jami-daemon

# Открываем необходимый порт для Jami bootstrap сервера (например, 4222)
EXPOSE 4222

# Копируем конфигурационный файл для bootstrap сервера (если нужен)
# COPY bootstrap.conf /etc/jami/bootstrap.conf

# Запуск bootstrap сервера Jami
CMD ["jami-daemon"]
