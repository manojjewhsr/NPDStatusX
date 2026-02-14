# Makefile for NPDStatusX
# This provides a simple interface for common build tasks

.PHONY: help clean restore build rebuild test all

# Default configuration
CONFIG ?= Release
SOLUTION = NPDStatusX.sln

# Detect OS and set appropriate commands
ifeq ($(OS),Windows_NT)
    # Windows
    MSBUILD ?= msbuild
    NUGET ?= nuget
    RM = del /F /Q
    RMDIR = rmdir /S /Q
else
    # Linux/macOS
    MSBUILD ?= msbuild
    NUGET ?= nuget
    RM = rm -f
    RMDIR = rm -rf
    
    # Try to use mono if msbuild not in PATH
    ifeq ($(shell command -v msbuild 2> /dev/null),)
        ifneq ($(shell command -v xbuild 2> /dev/null),)
            MSBUILD = xbuild
        endif
    endif
endif

# Default target
help:
	@echo "NPDStatusX Build Targets"
	@echo "========================"
	@echo ""
	@echo "Available targets:"
	@echo "  make help      - Show this help message"
	@echo "  make clean     - Clean build artifacts"
	@echo "  make restore   - Restore NuGet packages"
	@echo "  make build     - Build the solution"
	@echo "  make rebuild   - Clean, restore, and build"
	@echo "  make all       - Same as rebuild"
	@echo ""
	@echo "Configuration:"
	@echo "  CONFIG=Debug   - Build in Debug mode (default: Release)"
	@echo ""
	@echo "Examples:"
	@echo "  make rebuild"
	@echo "  make build CONFIG=Debug"
	@echo "  make clean"
	@echo ""

# Clean build artifacts
clean:
	@echo "Cleaning solution..."
	$(MSBUILD) $(SOLUTION) /t:Clean /p:Configuration=$(CONFIG) /v:minimal

# Restore NuGet packages
restore:
	@echo "Restoring NuGet packages..."
	$(NUGET) restore $(SOLUTION)

# Build the solution
build:
	@echo "Building solution (Configuration: $(CONFIG))..."
	$(MSBUILD) $(SOLUTION) /p:Configuration=$(CONFIG) /v:minimal

# Full rebuild
rebuild: clean restore build
	@echo "Rebuild completed successfully!"

# Alias for rebuild
all: rebuild
