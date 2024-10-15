# Используем базовый образ Ubuntu 20.04
FROM ubuntu:20.04

# Устанавливаем часовой пояс автоматически
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Отключаем интерактивные запросы в Git (например, запрос пароля)
ENV GIT_TERMINAL_PROMPT=0

# Обновляем пакеты и устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    cmake \
    pkg-config \
    libssl-dev \
    libsqlite3-dev \
    curl  # Устанавливаем curl для проверки подключения

# Проверяем доступность GitLab
RUN curl -I https://git.jami.net

# Отключаем проверку SSL (если возникнут проблемы с сертификатом)
# RUN git config --global http.sslVerify false

# Клонируем репозиторий Jami bootstrap с GitLab
RUN git clone https://git.jami.net/savoirfairelinux/jami-bootstrap.git /opt/jami-bootstrap

# Переходим в директорию проекта
WORKDIR /opt/jami-bootstrap

# Собираем проект Jami bootstrap
RUN cmake . && make

# Открываем порт, используемый bootstrap сервером (по умолчанию 8443)
EXPOSE 8443

# Команда для запуска bootstrap сервера
CMD ["./bootstrap"]
