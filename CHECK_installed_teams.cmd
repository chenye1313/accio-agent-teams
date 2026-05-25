@echo off
setlocal
set "ROOT=%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%install\check-win.ps1"
set "CODE=%ERRORLEVEL%"
echo.
echo Exit code: %CODE%
echo Press any key to close this window.
pause >nul
exit /b %CODE%
