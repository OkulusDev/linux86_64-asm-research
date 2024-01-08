ASM = fasm
LD = ld
LD_FLAGS = -m elf_x86_64

SRC_DIR = src
BIN_DIR = bin
SRC_FILES = $(wildcard $(SRC_DIR)/*.asm)
OBJ_FILES = $(patsubst $(SRC_DIR)/%.asm,$(BIN_DIR)/%.o,$(SRC_FILES))
EXECUTABLES = $(patsubst $(SRC_DIR)/%.asm,$(BIN_DIR)/%,$(SRC_FILES))

# Правило по умолчанию
all: $(EXECUTABLES) clean

build: $(EXECUTABLES)

# Правило для компиляции .asm файлов в .o файлы
$(BIN_DIR)/%.o: $(SRC_DIR)/%.asm
	$(ASM) $< $@

# Правило для линковки .o файлов
$(BIN_DIR)/%: $(BIN_DIR)/%.o
	$(LD) $(LD_FLAGS) $< -o $@

# Очистка сгенерированных файлов
clean:
	rm -f $(BIN_DIR)/*.o $(EXECUTABLES)
