@echo off
REM Batch rebuild script for NPDStatusX project
REM This script restores packages and builds the solution

setlocal enabledelayedexpansion

set SOLUTION_FILE=NPDStatusX.sln
set CONFIGURATION=Release
set DO_CLEAN=0
set DO_RESTORE=1
set DO_BUILD=1

REM Parse command line arguments
:parse_args
if "%~1"=="" goto end_parse
if /i "%~1"=="--clean" set DO_CLEAN=1
if /i "%~1"=="--restore" set DO_RESTORE=1& set DO_BUILD=0
if /i "%~1"=="--build" set DO_BUILD=1& set DO_RESTORE=0
if /i "%~1"=="--debug" set CONFIGURATION=Debug
if /i "%~1"=="--help" goto show_help
if /i "%~1"=="-h" goto show_help
shift
goto parse_args
:end_parse

echo ========================================
echo NPDStatusX Rebuild Script
echo ========================================
echo.

REM Check if solution file exists
if not exist "%SOLUTION_FILE%" (
    echo ERROR: Solution file '%SOLUTION_FILE%' not found!
    exit /b 1
)

REM Find MSBuild
set MSBUILD_PATH=
where msbuild >nul 2>&1
if %errorlevel%==0 (
    set MSBUILD_PATH=msbuild
    goto found_msbuild
)

REM Try to find MSBuild using vswhere
if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" (
    for /f "tokens=*" %%i in ('"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -requires Microsoft.Component.MSBuild -property installationPath') do (
        if exist "%%i\MSBuild\Current\Bin\MSBuild.exe" (
            set MSBUILD_PATH=%%i\MSBuild\Current\Bin\MSBuild.exe
            goto found_msbuild
        )
        if exist "%%i\MSBuild\15.0\Bin\MSBuild.exe" (
            set MSBUILD_PATH=%%i\MSBuild\15.0\Bin\MSBuild.exe
            goto found_msbuild
        )
    )
)

echo ERROR: MSBuild not found! Please install Visual Studio.
echo Download from: https://visualstudio.microsoft.com/
exit /b 1

:found_msbuild
echo Using MSBuild: %MSBUILD_PATH%

REM Find or download NuGet
set NUGET_PATH=
where nuget >nul 2>&1
if %errorlevel%==0 (
    set NUGET_PATH=nuget
) else (
    if exist "nuget.exe" (
        set NUGET_PATH=nuget.exe
    ) else (
        echo NuGet not found. Downloading nuget.exe...
        powershell -Command "Invoke-WebRequest -Uri 'https://dist.nuget.org/win-x86-commandline/latest/nuget.exe' -OutFile 'nuget.exe'"
        if exist "nuget.exe" (
            set NUGET_PATH=nuget.exe
            echo NuGet downloaded successfully.
        ) else (
            echo ERROR: Failed to download NuGet.
            exit /b 1
        )
    )
)

echo Using NuGet: %NUGET_PATH%
echo.

REM Clean
if %DO_CLEAN%==1 (
    echo Cleaning solution...
    "%MSBUILD_PATH%" "%SOLUTION_FILE%" /t:Clean /p:Configuration=%CONFIGURATION% /v:minimal
    if !errorlevel! neq 0 (
        echo ERROR: Clean failed!
        exit /b !errorlevel!
    )
    echo Clean completed successfully.
    echo.
)

REM Restore packages
if %DO_RESTORE%==1 (
    echo Restoring NuGet packages...
    "%NUGET_PATH%" restore "%SOLUTION_FILE%"
    if !errorlevel! neq 0 (
        echo ERROR: Package restore failed!
        exit /b !errorlevel!
    )
    echo Package restore completed successfully.
    echo.
)

REM Build
if %DO_BUILD%==1 (
    echo Building solution (Configuration: %CONFIGURATION%)...
    "%MSBUILD_PATH%" "%SOLUTION_FILE%" /p:Configuration=%CONFIGURATION% /v:minimal
    if !errorlevel! neq 0 (
        echo ERROR: Build failed!
        exit /b !errorlevel!
    )
    echo Build completed successfully.
    echo.
)

echo ========================================
echo Rebuild completed successfully!
echo ========================================
echo.
echo Build artifacts location:
echo   - bin\%CONFIGURATION%\
echo.
echo To deploy to IIS, copy the following files:
echo   - NPDStatusDashboard.aspx
echo   - NPDStatusDashboard.css
echo   - Web.config
echo   - bin\ folder (with all DLLs)
echo.
goto end

:show_help
echo NPDStatusX Rebuild Script
echo ========================
echo.
echo Usage: rebuild.bat [OPTIONS]
echo.
echo Options:
echo   --clean     Clean the solution before building
echo   --restore   Restore NuGet packages only
echo   --build     Build the solution only
echo   --debug     Build in Debug mode (default: Release)
echo   --help      Show this help message
echo.
echo Examples:
echo   rebuild.bat                  # Full rebuild (restore + build)
echo   rebuild.bat --clean          # Clean, restore, and build
echo   rebuild.bat --debug          # Build in Debug mode
echo   rebuild.bat --restore        # Only restore packages
echo   rebuild.bat --build          # Only build
echo.
goto end

:end
endlocal
