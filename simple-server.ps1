$port = 8888
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()

Write-Host "Server started at http://localhost:$port/"
Write-Host "Press Ctrl+C to stop"

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $request = $context.Request
    $response = $context.Response
    
    $path = $request.Url.LocalPath
    
    if ($path -eq "/save" -and $request.HttpMethod -eq "POST") {
        try {
            $reader = New-Object System.IO.StreamReader($request.InputStream, $request.ContentEncoding)
            $jsonData = $reader.ReadToEnd()
            $reader.Close()
            
            $filePath = "F:\Users\Administrator\AndroidStudioProjects\english-app-panel\words-data.json"
            [System.IO.File]::WriteAllText($filePath, $jsonData, [System.Text.Encoding]::UTF8)
            
            $message = 'File saved successfully'
            $buffer = [System.Text.Encoding]::UTF8.GetBytes($message)
            $response.ContentType = 'text/plain'
            $response.ContentLength64 = $buffer.Length
            $response.OutputStream.Write($buffer, 0, $buffer.Length)
            Write-Host "File saved successfully!"
        } catch {
            $message = 'Error: ' + $_.Exception.Message
            $buffer = [System.Text.Encoding]::UTF8.GetBytes($message)
            $response.StatusCode = 500
            $response.ContentType = 'text/plain'
            $response.ContentLength64 = $buffer.Length
            $response.OutputStream.Write($buffer, 0, $buffer.Length)
            Write-Host "Error: $_"
        }
    } else {
        # 静态文件服务
        if ($path -eq "/") { $path = "/adjust-categories.html" }
        
        $filePath = "F:\Users\Administrator\AndroidStudioProjects\english-app-panel" + $path.Replace("/", "\")
        
        if (Test-Path $filePath -PathType Leaf) {
            $content = [System.IO.File]::ReadAllBytes($filePath)
            $response.ContentLength64 = $content.Length
            $response.OutputStream.Write($content, 0, $content.Length)
        } else {
            $response.StatusCode = 404
            $message = 'File not found: ' + $path
            $buffer = [System.Text.Encoding]::UTF8.GetBytes($message)
            $response.ContentLength64 = $buffer.Length
            $response.OutputStream.Write($buffer, 0, $buffer.Length)
        }
    }
    
    $response.Close()
}

$listener.Stop()
