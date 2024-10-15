# Используем базовый образ Ubuntu
FROM ubuntu:20.04

# Устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    snapd \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем Jami
RUN snap install jami

# Открываем порт для Jami bootstrap сервера
EXPOSE 4222

# Запуск Jami bootstrap сервера
CMD ["jami-daemon"]
