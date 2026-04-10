@echo off
chcp 65001 >nul
echo ========================================
echo 正在以管理员身份启动服务器...
echo ========================================
echo.
echo 请确保点击"是"来允许管理员权限
echo.
powershell -Command "Start-Process PowerShell -ArgumentList '-ExecutionPolicy Bypass -File ""%~dp0server-admin.ps1""' -Verb RunAs"
