# Prompt the user to confirm before applying tweaks
Write-Host "This script will tweak your Windows settings. Are you sure you want to continue?" -ForegroundColor Yellow
$confirmation = Read-Host "Type 'yes' to continue, or anything else to cancel."

if ($confirmation -eq "yes") {
    # Define the tweaks to be applied
    $Tweaks = @{
        DarkModeEnabled = $true
        MouseAccelerationEnabled = $false
        NumLockEnabled = $true
        # Add more tweaks as needed
    }

    # Apply tweaks
    foreach ($tweakName in $Tweaks.Keys) {
        switch ($tweakName) {
            "DarkModeEnabled" {
                Invoke-WinUtilDarkMode -DarkMoveEnabled $Tweaks[$tweakName]
            }
            "MouseAccelerationEnabled" {
                Invoke-WinUtilMouseAcceleration -MouseAccelerationEnabled $Tweaks[$tweakName]
            }
            "NumLockEnabled" {
                Invoke-WinUtilNumLock -Enabled $Tweaks[$tweakName]
            }
            # Add more cases for additional tweaks
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
                Write-Host "Enabling Dark Mode" -ForegroundColor Green
                $DarkMoveValue = 1
            } else {
                Write-Host "Disabling Dark Mode" -ForegroundColor Green
                $DarkMoveValue = 0
            }
            $Path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
            Set-ItemProperty -Path $Path -Name AppsUseLightTheme -Value $DarkMoveValue
            Set-ItemProperty -Path $Path -Name SystemUsesLightTheme -Value $DarkMoveValue
        } catch {
            Write-Warning "Unable to set Dark Mode: $_"
        }
    }

    # Function to enable/disable Mouse Acceleration
    function Invoke-WinUtilMouseAcceleration {
        Param($MouseAccelerationEnabled)
        try {
            if ($MouseAccelerationEnabled) {
                Write-Host "Enabling Mouse Acceleration" -ForegroundColor Green
                $MouseSpeed = 1
                $MouseThreshold1 = 6
                $MouseThreshold2 = 10
            } else {
                Write-Host "Disabling Mouse Acceleration" -ForegroundColor Green
                $MouseSpeed = 0
                $MouseThreshold1 = 0
                $MouseThreshold2 = 0
            }
            $Path = "HKCU:\Control Panel\Mouse"
            Set-ItemProperty -Path $Path -Name MouseSpeed -Value $MouseSpeed
            Set-ItemProperty -Path $Path -Name MouseThreshold1 -Value $MouseThreshold1
            Set-ItemProperty -Path $Path -Name MouseThreshold2 -Value $MouseThreshold2
        } catch {
            Write-Warning "Unable to set Mouse Acceleration: $_"
        }
    }

    # Function to enable/disable NumLock on startup
    function Invoke-WinUtilNumLock {
        Param($Enabled)
        try {
            if ($Enabled) {
                Write-Host "Enabling Numlock on startup" -ForegroundColor Green
                $value = 2
            } else {
                Write-Host "Disabling Numlock on startup" -ForegroundColor Green
                $value = 0
            }
            $Path = "HKCU:\Control Panel\Keyboard"
            Set-ItemProperty -Path $Path -Name InitialKeyboardIndicators -Value $value
        } catch {
            Write-Warning "Unable to set NumLock: $_"
        }
    }

    # Add more tweak functions as needed
} else {
    Write-Host "Operation canceled. No changes were made." -ForegroundColor Yellow
}
