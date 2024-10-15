# Базовый образ
FROM ubuntu:20.04

# Устанавливаем часовой пояс автоматически
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Обновляем и устанавливаем зависимости
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    cmake \
    pkg-config \
    libssl-dev \
    libsqlite3-dev

# Клонируем репозиторий Jami bootstrap
RUN git clone https://git.jami.net/savoirfairelinux/jami-bootstrap.git /opt/jami-bootstrap

# Переходим в директорию проекта
WORKDIR /opt/jami-bootstrap

# Собираем проект
RUN cmake . && make

# Открываем нужный порт (по умолчанию 8443)
EXPOSE 8443

# Запускаем bootstrap сервер
CMD ["./bootstrap"]
