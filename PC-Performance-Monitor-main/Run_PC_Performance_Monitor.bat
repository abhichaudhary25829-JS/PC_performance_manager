@echo off
setlocal
title PC Performance Monitor

REM Run from this file's folder, even when double-clicked.
cd /d "%~dp0"

echo ==========================================
echo       PC Performance Monitor Launcher
echo ==========================================
echo.

REM Prefer the project's virtual environment.
set "PYTHON=%~dp0.venv\Scripts\python.exe"

if not exist "%PYTHON%" (
    REM Check one level down in case the project is nested.
    for /d %%D in ("%~dp0*") do (
        if exist "%%~fD\.venv\Scripts\python.exe" (
            set "PYTHON=%%~fD\.venv\Scripts\python.exe"
            set "PROJECT=%%~fD"
        )
    )
)

if not defined PROJECT set "PROJECT=%~dp0"
if not exist "%PYTHON%" (
    echo ERROR: Python virtual environment was not found.
    echo.
    echo Open VS Code in the folder containing requirements.txt and run:
    echo   py -m venv .venv
    echo   .venv\Scripts\python.exe -m pip install -r requirements.txt
    echo.
    pause
    exit /b 1
)

cd /d "%PROJECT%"

REM Choose a likely application entry point.
if exist "src\main.py" (
    echo Starting application: src.main
    "%PYTHON%" -m src.main
    goto finished
)

if exist "main.py" (
    echo Starting application: main.py
    "%PYTHON%" main.py
    goto finished
)

REM Search one folder down for common entry points.
for /d %%D in (*) do (
    if exist "%%D\src\main.py" (
        echo Starting application from %%D
        cd /d "%PROJECT%\%%D"
        "%PYTHON%" -m src.main
        goto finished
    )
    if exist "%%D\main.py" (
        echo Starting application from %%D\main.py
        cd /d "%PROJECT%\%%D"
        "%PYTHON%" main.py
        goto finished
    )
)

echo ERROR: Could not find src\main.py or main.py.
echo Open the README.md and check which file starts the app.
echo This launcher has not changed or deleted any project files.

:finished
echo.
echo If an error appeared above, take note of the message.
pause
endlocal
