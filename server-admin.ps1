$ipAddress = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -notlike '127.*' -and $_.IPAddress -notlike '169.254.*' } | Select-Object -First 1).IPAddress

if (-not $ipAddress) {
    $ipAddress = "192.168.101.6"
}

$port = 8080

# 注册URL前缀（需要管理员权限）
$localPrefix = "http://localhost:$port/"
$lanPrefix = "http://$ipAddress`:$port/"

Write-Host "正在注册URL前缀..."
Write-Host "本地前缀: $localPrefix"
Write-Host "局域网前缀: $lanPrefix"

# 使用netsh添加URL保留
$command1 = "netsh http add urlacl url=$localPrefix user=Everyone"
$command2 = "netsh http add urlacl url=$lanPrefix user=Everyone"

Invoke-Expression $command1 2>$null
Invoke-Expression $command2 2>$null

$listener = New-Object System.Net.HttpListener

try {
    $listener.Prefixes.Add($localPrefix)
    $listener.Prefixes.Add($lanPrefix)
    $listener.Start()
    
    Write-Host ""
    Write-Host "========================================"
    Write-Host "服务器已启动！"
    Write-Host "========================================"
    Write-Host "本地访问: http://localhost:$port/"
    Write-Host "局域网访问: http://$ipAddress`:$port/"
    Write-Host "========================================"
    Write-Host "手机访问地址: http://$ipAddress`:$port/"
    Write-Host "========================================"
    Write-Host "按 Ctrl+C 停止服务器"
    Write-Host "========================================"
    
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        $path = $request.Url.LocalPath
        if ($path -eq "/") { $path = "/index.html" }
        
        $filePath = Join-Path (Get-Location) $path.Substring(1)
        
        if (Test-Path $filePath) {
            $extension = [System.IO.Path]::GetExtension($filePath).ToLower()
            
            switch ($extension) {
                ".html" { $response.ContentType = "text/html; charset=utf-8" }
                ".css"  { $response.ContentType = "text/css; charset=utf-8" }
                ".js"   { $response.ContentType = "application/javascript; charset=utf-8" }
                ".json" { $response.ContentType = "application/json; charset=utf-8" }
                default { $response.ContentType = "text/plain; charset=utf-8" }
            }
            
            $content = Get-Content $filePath -Raw -Encoding UTF8
            $buffer = [System.Text.Encoding]::UTF8.GetBytes($content)
            $response.ContentLength64 = $buffer.Length
            $response.OutputStream.Write($buffer, 0, $buffer.Length)
        } else {
            $response.StatusCode = 404
            $buffer = [System.Text.Encoding]::UTF8.GetBytes("404 - Not Found")
            $response.ContentLength64 = $buffer.Length
            $response.OutputStream.Write($buffer, 0, $buffer.Length)
        }
        
        $response.Close()
    }
} catch {
    Write-Host "启动失败: $_"
    Write-Host ""
    Write-Host "请确保以管理员身份运行此脚本"
    pause
}
