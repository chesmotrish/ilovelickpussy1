# Используем базовый образ Ubuntu
FROM ubuntu:20.04

# Устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    software-properties-common && \
    rm -rf /var/lib/apt/lists/*

# Добавляем репозиторий Jami и ключ
RUN curl -fsSL https://dl.jami.net/nightly/ubuntu_20.04/jami.asc | gpg --dearmor -o /usr/share/keyrings/jami.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/jami.gpg] https://dl.jami.net/nightly/ubuntu_20.04/ ring main" > /etc/apt/sources.list.d/jami.list

# Устанавливаем Jami
RUN apt-get update && apt-get install -y jami-daemon && rm -rf /var/lib/apt/lists/*

# Открываем порт
EXPOSE 4222

# Запуск Jami
CMD ["jami-daemon"]
