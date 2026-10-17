@echo off
title MINI-ZAPRETIK [ALT6]

:: Administrator rights check
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
cd /d "%~dp0"

:: Kill previous instances
taskkill /IM winws.exe /F >nul 2>&1

echo [*] Starting Zapret ALT6 Core...
echo [*] Filtering by hostlist.txt only...

start "MINI-ZAPRETIK" /min "%~dp0winws.exe" --wf-tcp=80,443 --wf-udp=443 --filter-tcp=80,443 --hostlist="%~dp0hostlist.txt" --dpi-desync=multisplit --dpi-desync-split-seqovl=681 --dpi-desync-split-pos=1 --dpi-desync-split-seqovl-pattern="%~dp0tls_clienthello_www_google_com.bin" --new --filter-udp=443 --hostlist="%~dp0hostlist.txt" --dpi-desync=fake --dpi-desync-repeats=6

echo.
echo ========================================================
echo  MINI-ZAPRETIK is running!
echo  Only domains in hostlist.txt are desynced.
echo ========================================================
echo Press any key to stop...
pause > nul

taskkill /IM winws.exe /F >nul 2>&1
exit