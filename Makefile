# Устанавливаем компилятор
CC=gcc

# Определяем флаги компилятора
CFLAGS=-Wall -g

# Исходные файлы
SRC=$(wildcard src/*.c)

# Объектные файлы
OBJ=$(SRC:.c=.o)

# Имя итогового исполняемого файла
EXEC=simplexmq

# Правило по умолчанию
all: $(EXEC)

# Правило для сборки исполняемого файла
$(EXEC): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

# Правило для компиляции объектных файлов
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Очистка объектных файлов и исполняемого файла
clean:
	rm -f $(OBJ) $(EXEC)

# Устанавливаем сервер
install: $(EXEC)
	cp $(EXEC) /usr/local/bin/

# Удаляем сервер
uninstall:
	rm -f /usr/local/bin/$(EXEC)
