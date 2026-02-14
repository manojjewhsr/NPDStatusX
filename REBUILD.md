# NPDStatusX Rebuild Guide

This document describes how to rebuild the NPDStatusX project from source.

## Overview

The NPDStatusX project includes rebuild scripts for both Windows and Linux/macOS environments. These scripts automate the process of restoring NuGet packages and building the solution.

## Prerequisites

### Windows
- **Visual Studio 2017 or later** (Community, Professional, or Enterprise)
  - Required workload: "ASP.NET and web development"
- **MSBuild** (included with Visual Studio)
- **NuGet CLI** (optional - script will download if not found)

### Linux/macOS
- **Mono** (https://www.mono-project.com/download/stable/)
  - Includes msbuild or xbuild
- **NuGet CLI** (optional - script will download if not found)
- **.NET Framework 4.7.2 reference assemblies**

## Rebuild Scripts

### Windows (PowerShell)

The `rebuild.ps1` PowerShell script provides a comprehensive rebuild solution for Windows environments.

#### Basic Usage

```powershell
# Full rebuild (restore packages + build in Release mode)
.\rebuild.ps1

# Build in Debug mode
.\rebuild.ps1 -Configuration Debug

# Clean, restore, and build
.\rebuild.ps1 -Clean

# Only restore packages
.\rebuild.ps1 -Restore

# Only build (assumes packages already restored)
.\rebuild.ps1 -Build

# Show help
.\rebuild.ps1 -Help
```

#### Features
- Automatically locates MSBuild using vswhere
- Downloads NuGet.exe if not found
- Supports clean, restore, and build operations
- Configurable build configuration (Debug/Release)
- Colored console output for better readability
- Detailed error messages

### Linux/macOS (Bash)

The `rebuild.sh` bash script provides rebuild functionality for Unix-like environments.

#### Basic Usage

```bash
# Make script executable (first time only)
chmod +x rebuild.sh

# Full rebuild (restore packages + build in Release mode)
./rebuild.sh

# Build in Debug mode
./rebuild.sh -c Debug

# Clean, restore, and build
./rebuild.sh --clean

# Only restore packages
./rebuild.sh --restore

# Only build (assumes packages already restored)
./rebuild.sh --build

# Show help
./rebuild.sh --help
```

#### Features
- Works with both msbuild (Mono) and xbuild
- Downloads NuGet.exe if not found
- Supports clean, restore, and build operations
- Configurable build configuration (Debug/Release)
- Colored console output
- Compatible with various Unix shells

## Manual Build Process

If you prefer to build manually or the scripts don't work in your environment:

### Using Visual Studio

1. Open `NPDStatusX.sln` in Visual Studio
2. Right-click the solution → "Restore NuGet Packages"
3. Press F5 or select Build → Build Solution

### Using Command Line (Windows)

```batch
# Restore packages
nuget restore NPDStatusX.sln

# Build
msbuild NPDStatusX.sln /p:Configuration=Release
```

### Using Command Line (Linux/macOS with Mono)

```bash
# Restore packages
nuget restore NPDStatusX.sln

# Build
msbuild NPDStatusX.sln /p:Configuration=Release
# or
xbuild NPDStatusX.sln /p:Configuration=Release
```

## Build Output

After a successful build, you'll find the compiled files in:

- **Binary files**: `bin/Release/` (or `bin/Debug/`)
- **Web files**: The root directory contains the ASPX, CSS, and config files

### Deployment Files

To deploy the application to IIS, copy these files/folders:

```
NPDStatusDashboard.aspx
NPDStatusDashboard.css
Web.config
bin/ (entire folder with all DLLs)
```

## Build Configurations

### Debug Configuration
- Includes debug symbols (PDB files)
- No code optimization
- Useful for development and troubleshooting
- Build command: Use `-Configuration Debug` or `/p:Configuration=Debug`

### Release Configuration
- Optimized code
- Smaller binary size
- No debug symbols (unless configured)
- Recommended for production deployment
- Build command: Default or use `-Configuration Release`

## Troubleshooting

### Windows Issues

**Problem**: "MSBuild not found"
```
Solution: Install Visual Studio 2017 or later with ASP.NET workload
Download: https://visualstudio.microsoft.com/
```

**Problem**: "NuGet restore failed"
```
Solution: Check your internet connection and proxy settings
Or manually download NuGet.exe from https://dist.nuget.org/
```

**Problem**: "Package Oracle.ManagedDataAccess not found"
```
Solution: 
1. Check packages.config exists
2. Ensure NuGet package source is configured
3. Try: nuget restore -Force
```

### Linux/macOS Issues

**Problem**: "mono: command not found" or "msbuild not found"
```
Solution: Install Mono framework
- Ubuntu/Debian: sudo apt install mono-complete
- macOS: brew install mono
- Or download from: https://www.mono-project.com/download/stable/
```

**Problem**: ".NET Framework 4.7.2 reference assemblies not found"
```
Solution: Install the reference assemblies
sudo apt install mono-reference-assemblies-4.0
```

**Problem**: "Failed to download NuGet.exe"
```
Solution: Manually download and place in project root:
wget https://dist.nuget.org/win-x86-commandline/latest/nuget.exe
```

## CI/CD Integration

This project includes pre-configured GitHub Actions workflows for continuous integration.

### Available Workflows

**1. Build and Test** (`.github/workflows/build.yml`)
- Comprehensive build on Windows and Linux
- Tests all rebuild scripts
- Runs on multiple operating systems
- Uploads build artifacts

**2. Quick Build** (`.github/workflows/quick-build.yml`)
- Fast build using rebuild scripts
- Windows-only for .NET Framework compatibility
- Ideal for rapid testing

### GitHub Actions Example

```yaml
name: Build

on: [push, pull_request]

jobs:
  build:
    runs-on: windows-latest
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Setup MSBuild
      uses: microsoft/setup-msbuild@v2
    
    - name: Restore packages
      run: nuget restore NPDStatusX.sln
    
    - name: Build solution
      run: msbuild NPDStatusX.sln /p:Configuration=Release
```

### Using Rebuild Scripts in CI/CD

```yaml
# Windows CI with PowerShell script
- name: Rebuild project
  run: .\rebuild.ps1 -Configuration Release

# Linux CI with Bash script
- name: Rebuild project
  run: ./rebuild.sh -c Release
```

## Advanced Build Options

### Custom MSBuild Properties

```powershell
# Windows
.\rebuild.ps1
# Then edit the script to add custom properties like:
# /p:DeployOnBuild=true /p:PublishProfile=MyProfile
```

```bash
# Linux
./rebuild.sh
# MSBuild properties can be added in the script at the build command
```

### Package Restore Options

If you need to force package reinstallation:

```
nuget restore NPDStatusX.sln -Force
```

### Cleaning Build Artifacts

```powershell
# Windows
.\rebuild.ps1 -Clean
```

```bash
# Linux
./rebuild.sh --clean
```

## Build Performance Tips

1. **Use SSD**: Building on SSD drives significantly improves build times
2. **Close unnecessary applications**: Free up system resources
3. **Disable antivirus temporarily**: Some antivirus software slows down compilation
4. **Incremental builds**: Only changed files are recompiled (don't use -Clean unless needed)
5. **Parallel builds**: MSBuild uses multiple cores by default

## Related Documentation

- [INSTALLATION.md](INSTALLATION.md) - Full installation and deployment guide
- [README.md](README.md) - Project overview and features
- [ARCHITECTURE.md](ARCHITECTURE.md) - Technical architecture details
- [packages.config](packages.config) - NuGet package dependencies

## Support

For build issues:
1. Check this document for common solutions
2. Review error messages carefully
3. Verify all prerequisites are installed
4. Check for typos in configuration names
5. Ensure you have internet access for package restore

---

**Note**: This project was converted from Oracle APEX to ASP.NET Web Forms. See [APEX_to_WebForms_Mapping.md](APEX_to_WebForms_Mapping.md) for conversion details.
