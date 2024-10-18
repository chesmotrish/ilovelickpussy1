# Базовый образ Debian
FROM debian:bullseye-slim

# Устанавливаем зависимости
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Клонируем репозиторий Simplex
RUN git clone https://github.com/simplex-chat/simplexmq.git /app

# Переходим в директорию приложения
WORKDIR /app

# Собираем Simplex
RUN make

# Открываем порт 5222 для работы сервера
EXPOSE 5222

# Запускаем сервер Simplex
CMD ["./simplexmq"]
