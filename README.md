# PC Performance Monitor

A desktop application built with Python to monitor a computer's
performance in real time. It brings system metrics, process information,
performance scoring, and configurable alerts together in one interface.

## Features

-   **System monitoring:** View key system metrics such as CPU and
    memory usage.
-   **GPU monitoring:** Display GPU information when supported hardware
    and the optional NVIDIA monitoring dependency are available.
-   **Storage monitoring:** Inspect storage-related information.
-   **Process monitoring:** View running processes and their resource
    usage.
-   **Performance score:** Calculate an overall performance score from a
    system snapshot.
-   **Alerts:** Check monitored metrics against configured thresholds.
-   **Performance history:** Support for tracking performance
    information over time, depending on the configured modules.
-   **Desktop interface:** A graphical interface built with PySide6.
-   **Automated tests:** Tests for scoring and alert behavior.

> **Note:** Available metrics depend on the operating system, hardware,
> installed optional dependencies, and the implementation of each
> module. GPU metrics may not be available on every computer.

## Technology Stack

-   Python
-   PySide6 --- desktop GUI
-   psutil --- system and process metrics
-   SQLite --- local data storage, where used by the application
-   pytest --- automated testing
-   `nvidia-ml-py` --- optional NVIDIA GPU monitoring

## Project Structure

``` text
PC-Performance-Monitor/
├── assets/
│   └── icon.svg
├── src/
│   ├── alerts/       # Alert management
│   ├── monitor/      # System metric monitoring
│   ├── performance/  # Scoring and performance-related modules
│   ├── processes/    # Process monitoring
│   ├── ui/           # User interface components
│   ├── __init__.py
│   └── main.py       # Application entry point
├── tests/
│   ├── conftest.py
│   ├── test_alerts.py
│   └── test_score.py
├── .gitignore
├── LICENSE
├── pytest.ini
├── README.md
└── requirements.txt
```

The exact files may differ by version. Keep the structure in this README
aligned with the files in your checkout.

## Requirements

-   Windows, Linux, or macOS with a supported Python installation
-   Python 3.10 or newer is a reasonable starting point; use the version
    specified by the project or its dependencies if different
-   `pip`
-   A virtual environment is recommended

## Installation on Windows

Open PowerShell or the VS Code terminal in the project root --- the
folder containing `requirements.txt`, `src`, and `tests`.

### 1. Create a virtual environment

``` powershell
py -m venv .venv
```

### 2. Install dependencies

``` powershell
.\.venv\Scripts\python.exe -m pip install --upgrade pip
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
```

If `.venv` already exists, you do not need to create it again. Install
dependencies again only if they are missing or the requirements change.

## Run the Application

From the project root, run:

``` powershell
.\.venv\Scripts\python.exe -m src.main
```

Alternatively, activate the environment first:

``` powershell
.\.venv\Scripts\Activate.ps1
python -m src.main
```

If the command reports `No module named 'src'`, check that the terminal
is in the project root and that the `src` folder is directly inside it.

## Run the Tests

Run all automated tests:

``` powershell
.\.venv\Scripts\python.exe -m pytest -v
```

Run an individual test file:

``` powershell
.\.venv\Scripts\python.exe -m pytest -v tests/test_score.py
```

``` powershell
.\.venv\Scripts\python.exe -m pytest -v tests/test_alerts.py
```

Tests validate the behaviors implemented in the test suite; passing
tests do not guarantee that every hardware metric is supported on every
machine.

## One-Click Launch on Windows

You can create a batch file named `Run_PC_Performance_Monitor.bat` in
the project root (beside `src`, `.venv`, and `requirements.txt`) with
this content:

``` bat
@echo off
cd /d "%~dp0"
if not exist ".venv\Scripts\python.exe" (
    echo Virtual environment not found.
    echo Run: py -m venv .venv
    echo Then install dependencies with:
    echo .venv\Scripts\python.exe -m pip install -r requirements.txt
    pause
    exit /b 1
)
".venv\Scripts\python.exe" -m src.main
if errorlevel 1 pause
```

Save the file and double-click it to launch the application. The
first-time environment setup and dependency installation must be
completed before using the launcher.

## Troubleshooting

### `No module named 'src'`

-   Open the terminal in the project root.
-   Confirm that `src\main.py` exists.
-   Run `.\.venv\Scripts\python.exe -m src.main` from that root.

### `requirements.txt` not found

-   Use `Get-ChildItem` to check the current folder.
-   Change directory to the folder that contains `requirements.txt`.
-   Run the installation command again.

### Virtual environment not found

From the project root, run:

``` powershell
py -m venv .venv
```

Then install dependencies using the commands in the installation
section.

### GPU information is missing

GPU monitoring is hardware- and driver-dependent. The `nvidia-ml-py`
dependency is optional; NVIDIA-specific readings may not be available on
systems without compatible NVIDIA hardware and drivers.

## Development

-   Add monitoring logic in the appropriate module under `src/`.
-   Add or update tests under `tests/` when changing behavior.
-   Run `python -m pytest -v` before committing changes.
-   Keep dependencies documented in `requirements.txt`.

## Contributing

Contributions and suggestions are welcome. For changes, create a branch,
implement the change, run the tests, and submit a pull request with a
clear description.

## License

See the `LICENSE` file included in this repository for license terms.

------------------------------------------------------------------------

**Disclaimer:** This tool is intended for local system monitoring and
educational/development use. Metric availability and accuracy can vary
by hardware, drivers, permissions, and operating system.
