# 获取本机IP地址
$ipAddress = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -notlike '127.*' -and $_.IPAddress -notlike '169.254.*' } | Select-Object -First 1).IPAddress

if (-not $ipAddress) {
    Write-Host "无法获取IP地址，使用 localhost"
    $ipAddress = "localhost"
}

$port = 9000
$listener = New-Object System.Net.HttpListener

# 尝试添加前缀
$localPrefix = "http://localhost:$port/"
$lanPrefix = "http://$($ipAddress):$port/"

try {
    $listener.Prefixes.Add($localPrefix)
    Write-Host "成功添加本地前缀: $localPrefix"
} catch {
    Write-Host "添加本地前缀失败: $_"
}

try {
    $listener.Prefixes.Add($lanPrefix)
    Write-Host "成功添加局域网前缀: $lanPrefix"
} catch {
    Write-Host "添加局域网前缀失败，可能需要管理员权限运行"
    Write-Host "尝试只使用本地访问..."
}

try {
    $listener.Start()
    
    Write-Host ""
    Write-Host "========================================"
    Write-Host "服务器已启动！"
    Write-Host "========================================"
    Write-Host "本地访问: http://localhost:$port/"
    if ($listener.Prefixes -contains $lanPrefix) {
        Write-Host "局域网访问: http://$($ipAddress):$port/"
        Write-Host ""
        Write-Host "请在手机浏览器中输入:"
        Write-Host "http://$($ipAddress):$port/"
    } else {
        Write-Host ""
        Write-Host "注意: 局域网访问未启用"
        Write-Host "请以管理员身份运行PowerShell来启用局域网访问"
    }
    Write-Host ""
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
                ".png"  { $response.ContentType = "image/png" }
                ".jpg"  { $response.ContentType = "image/jpeg" }
                ".jpeg" { $response.ContentType = "image/jpeg" }
                ".gif"  { $response.ContentType = "image/gif" }
                ".svg"  { $response.ContentType = "image/svg+xml" }
                default { $response.ContentType = "text/plain; charset=utf-8" }
            }
            
            if ($extension -in @(".png", ".jpg", ".jpeg", ".gif", ".svg")) {
                $buffer = [System.IO.File]::ReadAllBytes($filePath)
            } else {
                $content = Get-Content $filePath -Raw -Encoding UTF8
                $buffer = [System.Text.Encoding]::UTF8.GetBytes($content)
            }
            
            $response.ContentLength64 = $buffer.Length
            $response.OutputStream.Write($buffer, 0, $buffer.Length)
        } else {
            $response.StatusCode = 404
            $buffer = [System.Text.Encoding]::UTF8.GetBytes("404 - File not found: $path")
            $response.ContentLength64 = $buffer.Length
            $response.OutputStream.Write($buffer, 0, $buffer.Length)
        }
        
        $response.Close()
    }
} catch {
    Write-Host "启动服务器失败: $_"
    Write-Host ""
    Write-Host "可能的解决方案:"
    Write-Host "1. 更换端口号（修改脚本中的 `$port` 变量）"
    Write-Host "2. 以管理员身份运行PowerShell"
    Write-Host "3. 检查是否有其他程序占用了该端口"
}
