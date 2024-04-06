# Set Power Plan to High Performance
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

# Disable Xbox Game Bar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Value 0

# Disable Nagle's Algorithm (may improve network latency)
New-NetTransportFilter -SettingName InternetCustom -LocalPortStart 0 -LocalPortEnd 65535 -RemotePortStart 0 -RemotePortEnd 65535 -NagleAlgorithm Disabled

# Disable Windows Search service
Set-Service -Name WSearch -StartupType Disabled
Stop-Service -Name WSearch

# Disable Windows Update service (Note: This is not recommended for security reasons. Consider enabling it after gaming sessions.)
Set-Service -Name wuauserv -StartupType Disabled
Stop-Service -Name wuauserv

# Disable Superfetch service
Set-Service -Name SysMain -StartupType Disabled
Stop-Service -Name SysMain

# Disable Windows Defender (Note: This is not recommended for security reasons.)
Set-MpPreference -DisableRealtimeMonitoring $true

# Disable unnecessary startup programs
Get-CimInstance Win32_StartupCommand | Disable-CimInstance

# Disable unnecessary background processes (Note: Be careful with this, as terminating critical processes can lead to system instability.)
# Examples: Disable Windows Error Reporting service
Set-Service -Name WerSvc -StartupType Disabled
Stop-Service -Name WerSvc

# Adjust system settings (you may need to adjust these based on your hardware and preferences)
# Example: Set CPU performance mode
# Note: Some settings may require third-party tools or registry modifications.
# Example: cpufreq -g performance

# Optimize network settings
# Example: Adjust network adapter settings for lower latency (MTU, Receive Side Scaling, etc.)
# Example: Use wired Ethernet connection instead of Wi-Fi for lower latency and higher stability

# Optimize game settings
# Example: Lower in-game graphics settings for higher FPS
# Example: Optimize game configurations for lower input lag

# Restart the system to apply changes
Restart-Computer -Force

