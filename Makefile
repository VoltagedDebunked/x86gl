# Variables
NASM = nasm
GCC = gcc
CFLAGS = -nostartfiles -no-pie -lGL -lglfw -lGLEW -lm -lpthread
ASM_SRC = src/main.asm
OBJ = main.o
EXEC = main

# Targets
all: $(EXEC)

$(EXEC): $(OBJ)
	@$(GCC) $(CFLAGS) $(OBJ) -o $(EXEC)

$(OBJ): $(ASM_SRC)
	@$(NASM) -f elf64 $(ASM_SRC) -o $(OBJ)

clean:
	@rm -rf $(EXEC) $(OBJ)