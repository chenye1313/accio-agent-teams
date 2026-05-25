@echo off
setlocal
set "ROOT=%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%install\local-win.ps1" -Team "foreign-trade-business-positioning-team" -Label "B_positioning"
set "CODE=%ERRORLEVEL%"
echo.
echo Exit code: %CODE%
echo Press any key to close this window.
pause >nul
exit /b %CODE%
