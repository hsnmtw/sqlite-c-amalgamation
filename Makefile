SRC_DIR := src
OBJ_DIR := obj
LIB_DIR := lib
INC_DIR := inc
BIN_DIR := bin
SQLITE  := sqlite-amalgamation-3500400
STRIP   := strip
CC      := gcc
EXE := $(BIN_DIR)/app.exe
SRC := $(wildcard $(SRC_DIR)/*.c)
CFLAGS := -I$(INC_DIR) -O3 -Wall -Werror -Wextra -pedantic -w -Wunused -faggressive-loop-optimizations -fanalyzer

all: clean sqlite3.a
	$(CC) $(SRC) $(LIB_DIR)/sqlite3.a -o $(EXE) $(CFLAGS)
	$(STRIP) --strip-debug $(EXE)
	$(EXE) 

sqlite3.a: sqlite3.o
	$(AR) rcs $(LIB_DIR)/sqlite3.a $(OBJ_DIR)/sqlite3.o

sqlite3.o:
	$(CC) -c  $(LIB_DIR)/$(SQLITE)/sqlite3.c -o $(OBJ_DIR)/sqlite3.o

clean:
	rm -rf $(EXE)
#	rm -rf $(LIB_DIR)/sqlite3.a
#	rm -rf $(OBJ_DIR)/sqlite3.o
