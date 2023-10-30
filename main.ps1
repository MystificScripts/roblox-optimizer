Write-Host ""
Write-Host "[+] Starting Optimizer installation..." -ForegroundColor Green
Write-Host ""

$found = $false

$versions = @()
$versions += Get-ChildItem "$env:LOCALAPPDATA\Roblox\Versions\" -Directory -ErrorAction SilentlyContinue
$versions += Get-ChildItem "C:\Program Files (x86)\Roblox\Versions\" -Directory -ErrorAction SilentlyContinue
$versions += Get-ChildItem "C:\Program Files\Roblox\Versions\" -Directory -ErrorAction SilentlyContinue

foreach ($version in $versions) {
    if (Test-Path "$($version.FullName)\RobloxPlayerBeta.exe") {
        $folder = $version.FullName
        $found = $true
        break
    }
}

if ($found) {
    if (-not (Test-Path "$folder\ClientSettings")) {
        New-Item -ItemType Directory -Path "$folder\ClientSettings"
    }

    Write-Host "[=] Downloading ClientAppSettings.json file..." -ForegroundColor Yellow

    try {
        (New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/ImJustRegularCoder/automation-proccess-codepulze/main/ClientAppSettings.json', "$folder\ClientSettings\ClientAppSettings.json")
        Write-Host "[+] ClientAppSettings.json downloaded successfully!" -ForegroundColor Green
        Write-Host ""
        Write-Host "[+] SUCCESS: Optimizer installation completed!" -ForegroundColor Green
    } catch {
        Write-Host "[-] Failed to download ClientAppSettings.json. Please report this issue to Thighlover on Discord." -ForegroundColor Red
        Write-Host ""
        Write-Host "[-] ERROR: Optimizer installation failed!" -ForegroundColor Red
    }
} else {
    Write-Host ""
    Write-Host "[-] ERROR: RobloxPlayerBeta.exe not found in any of the specified directories." -ForegroundColor Red
    Write-Host ""
    if (-not (Test-Path "C:\Program Files (x86)\Roblox\Versions\")) {
        Write-Host "C:\Program Files (x86)\Roblox\Versions\ doesn't exist, continuing..." -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "[=] NOTE:" -ForegroundColor Yellow
Write-Host ""
Write-Host "[=] 1. Run this script every time there is a Roblox update because they keep making changes." -ForegroundColor Yellow
Write-Host ""
Write-Host "[=] 2. If you need help, ping thighlover on discord.gg/mystific" -ForegroundColor Yellow
Write-Host ""
Write-Host ""
Read-Host -Prompt "[=] Press Enter to continue"
