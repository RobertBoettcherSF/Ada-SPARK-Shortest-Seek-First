# Makefile for SSTF Project
# Provides alternative build system

# Compiler settings
COMPILER ?= gprbuild
CFLAGS ?= -gnat2012 -gnata -gnato -gnatwa

# Directories
SRC_DIR = src
TEST_DIR = tests
DEMO_DIR = demo
OBJ_DIR = obj
BIN_DIR = bin

# Targets
.PHONY: all build test demo clean help

all: build

build: 
	mkdir -p $(OBJ_DIR) $(BIN_DIR)
	$(COMPILER) -P sstf_all.gpr -j0

test: 
	mkdir -p $(OBJ_DIR)/test $(BIN_DIR)
	$(COMPILER) -P tests/test_runner.gpr -j0
	./$(BIN_DIR)/test_runner

demo: 
	mkdir -p $(OBJ_DIR)/demo $(BIN_DIR)
	$(COMPILER) -P demo/sstf_demo.gpr -j0
	./$(BIN_DIR)/sstf_demo

demo-interactive: 
	mkdir -p $(OBJ_DIR)/demo $(BIN_DIR)
	$(COMPILER) -P demo/sstf_demo.gpr -j0
	./$(BIN_DIR)/sstf_demo interactive

clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

help:
	@echo "SSTF Project Makefile"
	@echo "====================="
	@echo ""
	@echo "Targets:"
	@echo "  make build      - Build all components"
	@echo "  make test       - Build and run tests"
	@echo "  make demo       - Build and run demo"
	@echo "  make demo-interactive - Build and run interactive demo"
	@echo "  make clean      - Clean build artifacts"
	@echo "  make help       - Show this help"
	@echo ""
