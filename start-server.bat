@echo off
chcp 65001 >nul
echo ========================================
echo 正在启动局域网服务器...
echo ========================================
echo.
echo 请确保手机和电脑在同一个WiFi网络下
echo.
echo 手机访问地址：
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4" ^| findstr /v "127.0.0.1"') do (
    set ip=%%a
    set ip=!ip: =!
    echo http://!ip!:9000/
    goto :found
)
:found
echo.
echo ========================================
echo 按 Ctrl+C 停止服务器
echo ========================================
echo.
python -m http.server 9000
pause
