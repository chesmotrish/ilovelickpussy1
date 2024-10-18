# Базовый образ Debian
FROM debian:bullseye-slim

# Устанавливаем необходимые пакеты
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Клонируем репозиторий Simplex
RUN git clone https://github.com/simplex-chat/simplexmq.git /app

# Переходим в директорию приложения
WORKDIR /app

# Устанавливаем дополнительные зависимости, если они требуются
# Например, для работы с шифрованием
RUN apt-get install -y libssl-dev

# Запускаем процесс сборки с использованием Makefile
RUN make

# Открываем порт 5222 для работы сервера
EXPOSE 5222

# Устанавливаем приложение
RUN make install

# Запускаем сервер Simplex
CMD ["simplexmq"]
