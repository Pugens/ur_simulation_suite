$commands = @(
    "get serial number"
    "get robot model"
    "safetystatus"
    "get operational mode"
    "quit"
)

try {
    $client = New-Object System.Net.Sockets.TcpClient("localhost", 29999)
    $stream = $client.GetStream()
    $reader = New-Object System.IO.StreamReader($stream)
    $writer = New-Object System.IO.StreamWriter($stream)
    $writer.AutoFlush = $true

    # Read the welcome banner
    Write-Host $reader.ReadLine()

    foreach ($cmd in $commands) {
        $writer.WriteLine($cmd)
        Start-Sleep -Milliseconds 200
        while ($stream.DataAvailable) {
            Write-Host $reader.ReadLine()
        }
    }

    $reader.Close()
    $writer.Close()
    $client.Close()
} catch {
    Write-Error "Failed to connect to dashboard server on localhost:29999 - is the container running?"
}
