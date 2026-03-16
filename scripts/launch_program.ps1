param(
    [string]$Program
)

# Discover available .urp files from the container
$urpFiles = docker exec ursim-container find /ursim/programs -name "*.urp" 2>$null |
    ForEach-Object { $_ -replace "^/ursim/programs/", "" }

if (-not $urpFiles) {
    Write-Error "No .urp files found in the container. Is it running?"
    exit 1
}

if (-not $Program) {
    Write-Host "Available programs:"
    for ($i = 0; $i -lt $urpFiles.Count; $i++) {
        Write-Host "  [$($i + 1)] $($urpFiles[$i])"
    }
    $choice = Read-Host "Select a program (1-$($urpFiles.Count))"
    $index = [int]$choice - 1
    if ($index -lt 0 -or $index -ge $urpFiles.Count) {
        Write-Error "Invalid selection."
        exit 1
    }
    $Program = $urpFiles[$index]
}
elseif ($Program -notin $urpFiles) {
    Write-Error "Program '$Program' not found. Available programs:"
    $urpFiles | ForEach-Object { Write-Host "  $_" }
    exit 1
}

Write-Host "Loading: $Program"

$commands = @(
    "load $Program"
    "play"
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
        Start-Sleep -Milliseconds 500
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
