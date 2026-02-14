#!/bin/bash
# Bash rebuild script for NPDStatusX project
# This script restores packages and builds the solution using Mono

set -e

# Default configuration
CONFIGURATION="Release"
DO_CLEAN=false
DO_RESTORE=false
DO_BUILD=false
SHOW_HELP=false

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -c|--configuration)
            CONFIGURATION="$2"
            shift 2
            ;;
        --clean)
            DO_CLEAN=true
            shift
            ;;
        --restore)
            DO_RESTORE=true
            shift
            ;;
        --build)
            DO_BUILD=true
            shift
            ;;
        -h|--help)
            SHOW_HELP=true
            shift
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            exit 1
            ;;
    esac
done

# Display help
if [ "$SHOW_HELP" = true ]; then
    cat <<EOF
NPDStatusX Rebuild Script (Linux/macOS)
======================================

Usage: ./rebuild.sh [OPTIONS]

Options:
  -c, --configuration <config>  Build configuration (Debug or Release). Default: Release
  --clean                       Clean the solution before building
  --restore                     Restore NuGet packages only
  --build                       Build the solution only
  -h, --help                    Show this help message

Examples:
  ./rebuild.sh                           # Full rebuild (restore + build)
  ./rebuild.sh --clean                   # Clean, restore, and build
  ./rebuild.sh -c Debug                  # Build in Debug mode
  ./rebuild.sh --restore                 # Only restore packages
  ./rebuild.sh --build                   # Only build (assumes packages are restored)

Requirements:
  - Mono (with xbuild or msbuild)
  - NuGet CLI tool
  - .NET Framework 4.7.2 reference assemblies

EOF
    exit 0
fi

SOLUTION_FILE="NPDStatusX.sln"

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}NPDStatusX Rebuild Script${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""

# Check if solution file exists
if [ ! -f "$SOLUTION_FILE" ]; then
    echo -e "${RED}ERROR: Solution file '$SOLUTION_FILE' not found!${NC}"
    exit 1
fi

# Check for mono and msbuild/xbuild
MSBUILD_PATH=""
if command -v msbuild &> /dev/null; then
    MSBUILD_PATH="msbuild"
    echo -e "${GREEN}Found msbuild${NC}"
elif command -v xbuild &> /dev/null; then
    MSBUILD_PATH="xbuild"
    echo -e "${GREEN}Found xbuild${NC}"
else
    echo -e "${RED}ERROR: Neither msbuild nor xbuild found!${NC}"
    echo -e "${YELLOW}Please install Mono: https://www.mono-project.com/download/stable/${NC}"
    exit 1
fi

# Check for NuGet
NUGET_PATH=""
if command -v nuget &> /dev/null; then
    NUGET_PATH="nuget"
elif [ -f "nuget.exe" ]; then
    NUGET_PATH="mono nuget.exe"
else
    echo -e "${YELLOW}NuGet not found. Downloading nuget.exe...${NC}"
    if command -v wget &> /dev/null; then
        wget -q https://dist.nuget.org/win-x86-commandline/latest/nuget.exe
    elif command -v curl &> /dev/null; then
        curl -sL https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -o nuget.exe
    else
        echo -e "${RED}ERROR: Neither wget nor curl found. Cannot download NuGet.${NC}"
        exit 1
    fi
    
    if [ -f "nuget.exe" ]; then
        NUGET_PATH="mono nuget.exe"
        echo -e "${GREEN}NuGet downloaded successfully.${NC}"
    else
        echo -e "${RED}ERROR: Failed to download NuGet.${NC}"
        exit 1
    fi
fi

echo -e "${GREEN}Using build tool: $MSBUILD_PATH${NC}"
echo -e "${GREEN}Using NuGet: $NUGET_PATH${NC}"
echo ""

# If no specific action is specified, do both restore and build
if [ "$DO_RESTORE" = false ] && [ "$DO_BUILD" = false ]; then
    DO_RESTORE=true
    DO_BUILD=true
fi

# Clean
if [ "$DO_CLEAN" = true ]; then
    echo -e "${YELLOW}Cleaning solution...${NC}"
    $MSBUILD_PATH "$SOLUTION_FILE" /t:Clean /p:Configuration="$CONFIGURATION" /v:minimal
    echo -e "${GREEN}Clean completed successfully.${NC}"
    echo ""
fi

# Restore packages
if [ "$DO_RESTORE" = true ]; then
    echo -e "${YELLOW}Restoring NuGet packages...${NC}"
    $NUGET_PATH restore "$SOLUTION_FILE"
    echo -e "${GREEN}Package restore completed successfully.${NC}"
    echo ""
fi

# Build
if [ "$DO_BUILD" = true ]; then
    echo -e "${YELLOW}Building solution (Configuration: $CONFIGURATION)...${NC}"
    $MSBUILD_PATH "$SOLUTION_FILE" /p:Configuration="$CONFIGURATION" /v:minimal
    echo -e "${GREEN}Build completed successfully.${NC}"
    echo ""
fi

echo -e "${CYAN}========================================${NC}"
echo -e "${GREEN}Rebuild completed successfully!${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""
echo -e "${CYAN}Build artifacts location:${NC}"
echo -e "  - bin/$CONFIGURATION/"
echo ""
echo -e "${CYAN}To deploy to IIS, copy the following files:${NC}"
echo -e "  - NPDStatusDashboard.aspx"
echo -e "  - NPDStatusDashboard.css"
echo -e "  - Web.config"
echo -e "  - bin/ folder (with all DLLs)"
echo ""
