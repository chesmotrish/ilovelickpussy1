# Используем базовый образ IPFS
FROM ipfs/go-ipfs:latest

# Открываем необходимые порты
EXPOSE 4001/tcp 4001/udp 5001 8080

# Настраиваем команду для запуска IPFS
CMD ["ipfs", "daemon", "--enable-gc", "--migrate=true"]

