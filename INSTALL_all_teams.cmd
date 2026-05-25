@echo off
setlocal
set "ROOT=%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%install\local-win.ps1" -Team "enterprise-knowledge-assets-team" -Label "A_knowledge"
if errorlevel 1 goto fail
powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%install\local-win.ps1" -Team "foreign-trade-business-positioning-team" -Label "B_positioning"
if errorlevel 1 goto fail
echo.
echo Both teams finished.
echo Press any key to close this window.
pause >nul
exit /b 0
:fail
echo.
echo Install failed. Please send the install-log-*.txt file in this folder.
echo Press any key to close this window.
pause >nul
exit /b 1
