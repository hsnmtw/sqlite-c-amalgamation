SRC_DIR := src
INC_DIR := inc
BIN_DIR := bin
SQLITE  := $(INC_DIR)/sqlite3
STRIP   := strip
CC      := gcc
EXE     := $(BIN_DIR)/app.exe
SRC     := $(wildcard $(SRC_DIR)/*.c)
CFLAGS  := -march=x86-64 -O3 -Wall -Werror -Wextra -pedantic -w -Wunused -faggressive-loop-optimizations -fanalyzer

all: clean | sqlite3.a
	$(CC) $(CFLAGS) $(SRC) sqlite3.a -o $(EXE)
	$(STRIP) --strip-debug $(EXE)
	$(EXE) 

sqlite3.a: 
	$(CC) -c $(SQLITE)/sqlite3.c -o sqlite3.o
	$(STRIP) --strip-debug sqlite3.o
	$(AR) rcs sqlite3.a sqlite3.o

clean:
	rm -rf $(EXE)