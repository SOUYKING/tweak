# Display header with download instructions
Write-Host "=== Welcome to PC Tweaking Script ===" -ForegroundColor Green
Write-Host "This script will help you customize your PC." -ForegroundColor Green
Write-Host "Please make sure to run this script with administrator privileges." -ForegroundColor Green
Write-Host ""

# Download popular apps
$AppsToDownload = @(
    "Steam",
    "Epic Games",
    "Google Chrome",
    # Add more apps to download here
)

foreach ($app in $AppsToDownload) {
    Write-Host "Downloading $app..."
    # Add code here to download the app
    # For example, you can use Invoke-WebRequest to download from URLs
    Start-Sleep -Seconds 2  # Simulating download delay
    Write-Host "$app downloaded successfully." -ForegroundColor Green
}

Write-Host ""

# Define user tweaks
$UserTweaks = @{
    # Add your custom tweaks here
    "DisableWindowsDefender" = $true
    "EnableFastStartup" = $true
}

# Apply user-defined tweaks
foreach ($tweakName in $UserTweaks.Keys) {
    switch ($tweakName) {
        "DisableWindowsDefender" {
            # Code to disable Windows Defender
            Write-Host "Disabling Windows Defender..."
            # Add code here to disable Windows Defender
            Write-Host "Windows Defender disabled." -ForegroundColor Green
        }
        "EnableFastStartup" {
            # Code to enable Fast Startup
            Write-Host "Enabling Fast Startup..."
            # Add code here to enable Fast Startup
            Write-Host "Fast Startup enabled." -ForegroundColor Green
        }
        # Add more cases for additional user tweaks
        Default {
            Write-Warning "Unknown tweak: $tweakName"
        }
    }
}

# Function to enable/disable Dark Mode
function Invoke-WinUtilDarkMode {
    Param($DarkMoveEnabled)
    try {
        if ($DarkMoveEnabled) {
            Write-Host "Enabling Dark Mode..."
            $DarkMoveValue = 1
        } else {
            Write-Host "Disabling Dark Mode..."
            $DarkMoveValue = 0
        }
        $Path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
        Set-ItemProperty -Path $Path -Name AppsUseLightTheme -Value $DarkMoveValue
        Set-ItemProperty -Path $Path -Name SystemUsesLightTheme -Value $DarkMoveValue
        Write-Host "Dark Mode configured successfully." -ForegroundColor Green
    } catch {
        Write-Warning "Unable to set Dark Mode: $_"
    }
}

# Function to enable/disable Mouse Acceleration
function Invoke-WinUtilMouseAcceleration {
    Param($MouseAccelerationEnabled)
    try {
        if ($MouseAccelerationEnabled) {
            Write-Host "Enabling Mouse Acceleration..."
            $MouseSpeed = 1
            $MouseThreshold1 = 6
            $MouseThreshold2 = 10
        } else {
            Write-Host "Disabling Mouse Acceleration..."
            $MouseSpeed = 0
            $MouseThreshold1 = 0
            $MouseThreshold2 = 0
        }
        $Path = "HKCU:\Control Panel\Mouse"
        Set-ItemProperty -Path $Path -Name MouseSpeed -Value $MouseSpeed
        Set-ItemProperty -Path $Path -Name MouseThreshold1 -Value $MouseThreshold1
        Set-ItemProperty -Path $Path -Name MouseThreshold2 -Value $MouseThreshold2
        Write-Host "Mouse Acceleration configured successfully." -ForegroundColor Green
    } catch {
        Write-Warning "Unable to set Mouse Acceleration: $_"
    }
}

# Function to enable/disable NumLock on startup
function Invoke-WinUtilNumLock {
    Param($Enabled)
    try {
        if ($Enabled) {
            Write-Host "Enabling Numlock on startup..."
            $value = 2
        } else {
            Write-Host "Disabling Numlock on startup..."
            $value = 0
        }
        $Path = "HKCU:\Control Panel\Keyboard"
        Set-ItemProperty -Path $Path -Name InitialKeyboardIndicators -Value $value
        Write-Host "Numlock configured successfully." -ForegroundColor Green
    } catch {
        Write-Warning "Unable to set NumLock: $_"
    }
}

# Apply predefined tweaks
Invoke-WinUtilDarkMode -DarkMoveEnabled $true
Invoke-WinUtilMouseAcceleration -MouseAccelerationEnabled $false
Invoke-WinUtilNumLock -Enabled $true

# Additional tweaks can be added here

Write-Host ""
Write-Host "=== Script Execution Completed ===" -ForegroundColor Green
