#!/usr/bin/env pwsh
# PowerShell rebuild script for NPDStatusX project
# This script restores packages and builds the solution

param(
    [string]$Configuration = "Release",
    [switch]$Clean,
    [switch]$Restore,
    [switch]$Build,
    [switch]$Help
)

# Display help
if ($Help) {
    Write-Host @"
NPDStatusX Rebuild Script
========================

Usage: ./rebuild.ps1 [-Configuration <config>] [-Clean] [-Restore] [-Build] [-Help]

Parameters:
  -Configuration   Build configuration (Debug or Release). Default: Release
  -Clean          Clean the solution before building
  -Restore        Restore NuGet packages only
  -Build          Build the solution only
  -Help           Show this help message

Examples:
  ./rebuild.ps1                           # Full rebuild (restore + build)
  ./rebuild.ps1 -Clean                    # Clean, restore, and build
  ./rebuild.ps1 -Configuration Debug      # Build in Debug mode
  ./rebuild.ps1 -Restore                  # Only restore packages
  ./rebuild.ps1 -Build                    # Only build (assumes packages are restored)

"@
    exit 0
}

$ErrorActionPreference = "Stop"
$SolutionFile = "NPDStatusX.sln"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "NPDStatusX Rebuild Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if solution file exists
if (-not (Test-Path $SolutionFile)) {
    Write-Host "ERROR: Solution file '$SolutionFile' not found!" -ForegroundColor Red
    exit 1
}

# Check for MSBuild
$msbuildPath = $null
$vsWhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"

if (Test-Path $vsWhere) {
    Write-Host "Locating MSBuild using vswhere..." -ForegroundColor Yellow
    $vsPath = & $vsWhere -latest -products * -requires Microsoft.Component.MSBuild -property installationPath
    if ($vsPath) {
        $msbuildPath = Join-Path $vsPath "MSBuild\Current\Bin\MSBuild.exe"
        if (-not (Test-Path $msbuildPath)) {
            $msbuildPath = Join-Path $vsPath "MSBuild\15.0\Bin\MSBuild.exe"
        }
    }
}

# Fallback to PATH
if (-not $msbuildPath -or -not (Test-Path $msbuildPath)) {
    Write-Host "Searching for MSBuild in PATH..." -ForegroundColor Yellow
    $msbuildPath = (Get-Command msbuild -ErrorAction SilentlyContinue).Source
}

if (-not $msbuildPath) {
    Write-Host "ERROR: MSBuild not found! Please install Visual Studio or .NET SDK." -ForegroundColor Red
    Write-Host "Download from: https://visualstudio.microsoft.com/" -ForegroundColor Yellow
    exit 1
}

Write-Host "Using MSBuild: $msbuildPath" -ForegroundColor Green
Write-Host ""

# Check for NuGet
$nugetPath = $null
$nugetPath = (Get-Command nuget -ErrorAction SilentlyContinue).Source

if (-not $nugetPath) {
    Write-Host "NuGet not found in PATH. Downloading nuget.exe..." -ForegroundColor Yellow
    $nugetPath = Join-Path $PSScriptRoot "nuget.exe"
    
    if (-not (Test-Path $nugetPath)) {
        try {
            $nugetUrl = "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"
            Invoke-WebRequest -Uri $nugetUrl -OutFile $nugetPath
            Write-Host "NuGet downloaded successfully." -ForegroundColor Green
        }
        catch {
            Write-Host "ERROR: Failed to download NuGet.exe: $_" -ForegroundColor Red
            exit 1
        }
    }
}

Write-Host "Using NuGet: $nugetPath" -ForegroundColor Green
Write-Host ""

# Clean
if ($Clean) {
    Write-Host "Cleaning solution..." -ForegroundColor Yellow
    & $msbuildPath $SolutionFile /t:Clean /p:Configuration=$Configuration /v:minimal
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Clean failed!" -ForegroundColor Red
        exit $LASTEXITCODE
    }
    Write-Host "Clean completed successfully." -ForegroundColor Green
    Write-Host ""
}

# Restore packages (default action if no specific action specified)
if ($Restore -or (-not $Build -and -not $Restore)) {
    Write-Host "Restoring NuGet packages..." -ForegroundColor Yellow
    & $nugetPath restore $SolutionFile
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Package restore failed!" -ForegroundColor Red
        exit $LASTEXITCODE
    }
    Write-Host "Package restore completed successfully." -ForegroundColor Green
    Write-Host ""
}

# Build (default action if no specific action specified)
if ($Build -or (-not $Build -and -not $Restore)) {
    Write-Host "Building solution (Configuration: $Configuration)..." -ForegroundColor Yellow
    & $msbuildPath $SolutionFile /p:Configuration=$Configuration /p:DeployOnBuild=true /v:minimal
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Build failed!" -ForegroundColor Red
        exit $LASTEXITCODE
    }
    Write-Host "Build completed successfully." -ForegroundColor Green
    Write-Host ""
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Rebuild completed successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Build artifacts location:" -ForegroundColor Cyan
Write-Host "  - bin\$Configuration\" -ForegroundColor White
Write-Host ""
Write-Host "To deploy to IIS, copy the following files:" -ForegroundColor Cyan
Write-Host "  - NPDStatusDashboard.aspx" -ForegroundColor White
Write-Host "  - NPDStatusDashboard.css" -ForegroundColor White
Write-Host "  - Web.config" -ForegroundColor White
Write-Host "  - bin\ folder (with all DLLs)" -ForegroundColor White
Write-Host ""
