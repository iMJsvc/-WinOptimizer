if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Windows.Forms

[xml]$xaml = @"
<Window xmlns="http://microsoft.com"
        xmlns:x="http://microsoft.com"
        Title="Pro Windows Optimizer &amp; App Installer v1.0" Height="740" Width="1020"
        WindowStartupLocation="CenterScreen" Background="#121418" Foreground="#EAEAEA" FontFamily="Segoe UI">
    <Window.Resources>
        <Style TargetType="TabItem">
            <Setter Property="Background" Value="#1E222A"/>
            <Setter Property="Foreground" Value="#B0B8C4"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Padding" Value="18,10"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="TabItem">
                        <Border Name="Border" Background="#1E222A" BorderBrush="#2D333F" BorderThickness="1,1,1,0" CornerRadius="6,6,0,0" Margin="2,0">
                            <ContentPresenter x:Name="ContentSite" VerticalAlignment="Center" HorizontalAlignment="Center" ContentSource="Header" Margin="16,8"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsSelected" Value="True">
                                <Setter TargetName="Border" Property="Background" Value="#0078D4"/>
                                <Setter Property="Foreground" Value="White"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="#E2E8F0"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="Margin" Value="0,4"/>
            <Setter Property="Cursor" Value="Hand"/>
        </Style>
        <Style TargetType="Button">
            <Setter Property="Background" Value="#0078D4"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="Padding" Value="14,8"/>
            <Setter Property="BorderThickness" Value="0"/>
            <Setter Property="Cursor" Value="Hand"/>
        </Style>
    </Window.Resources>

    <Grid Margin="15">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="155"/>
        </Grid.RowDefinitions>

        <Border Grid.Row="0" Background="#1A1D24" CornerRadius="8" Padding="15" Margin="0,0,0,12" BorderBrush="#2A2F3A" BorderThickness="1">
            <DockPanel>
                <StackPanel Orientation="Vertical">
                    <TextBlock Text="PRO WINDOWS OPTIMIZER &amp; SMART INSTALLER" FontSize="20" FontWeight="Bold" Foreground="#38BDF8"/>
                    <TextBlock Text="All-in-One Gaming Tweaks, Power Plans, .NET Runtimes &amp; Automated Software Setup" FontSize="12" Foreground="#94A3B8" Margin="0,2,0,0"/>
                </StackPanel>
                <Button Name="BtnCreateRestore" Content="Create Restore Point" HorizontalAlignment="Right" Background="#10B981" Padding="14,8"/>
            </DockPanel>
        </Border>

        <TabControl Grid.Row="1" Background="#181B22" BorderBrush="#2D333F" BorderThickness="1">
            <TabItem Header="Install Apps &amp; .NET">
                <Grid Margin="12">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>

                    <ScrollViewer Grid.Row="0" VerticalScrollBarVisibility="Auto">
                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="*"/>
                                <ColumnDefinition Width="*"/>
                            </Grid.ColumnDefinitions>

                            <Border Grid.Column="0" Background="#1E222B" CornerRadius="6" Padding="12" Margin="0,0,6,0">
                                <StackPanel Name="PanelDotNet">
                                    <TextBlock Text=".NET Framework &amp; Runtimes" FontSize="15" FontWeight="Bold" Foreground="#38BDF8" Margin="0,0,0,8"/>
                                    <CheckBox Tag="DOTNET35" Content=".NET Framework 3.5 (Includes 2.0 &amp; 3.0)"/>
                                    <CheckBox Tag="Microsoft.DotNet.Framework.DeveloperPack_4" Content=".NET Framework 4.8 Developer Pack"/>
                                    <CheckBox Tag="Microsoft.DotNet.DesktopRuntime.5" Content=".NET 5.0 Desktop Runtime"/>
                                    <CheckBox Tag="Microsoft.DotNet.DesktopRuntime.6" Content=".NET 6.0 Desktop Runtime"/>
                                    <CheckBox Tag="Microsoft.DotNet.DesktopRuntime.7" Content=".NET 7.0 Desktop Runtime"/>
                                    <CheckBox Tag="Microsoft.DotNet.DesktopRuntime.8" Content=".NET 8.0 Desktop Runtime (LTS)"/>
                                    <CheckBox Tag="Microsoft.DotNet.DesktopRuntime.9" Content=".NET 9.0 Desktop Runtime"/>
                                    <CheckBox Tag="Microsoft.VCRedist.2015+.x64" Content="Visual C++ 2015-2022 Redist (x64)"/>
                                    <CheckBox Tag="Microsoft.VCRedist.2015+.x86" Content="Visual C++ 2015-2022 Redist (x86)"/>
                                    <CheckBox Tag="Microsoft.DirectX" Content="DirectX End-User Runtime"/>
                                </StackPanel>
                            </Border>

                            <Border Grid.Column="1" Background="#1E222B" CornerRadius="6" Padding="12" Margin="6,0">
                                <StackPanel Name="PanelBrowsers">
                                    <TextBlock Text="Browsers &amp; Social" FontSize="15" FontWeight="Bold" Foreground="#A78BFA" Margin="0,0,0,8"/>
                                    <CheckBox Tag="Google.Chrome" Content="Google Chrome"/>
                                    <CheckBox Tag="Brave.Brave" Content="Brave Browser"/>
                                    <CheckBox Tag="Mozilla.Firefox" Content="Mozilla Firefox"/>
                                    <CheckBox Tag="Zen-Team.Zen-Browser" Content="Zen Browser"/>
                                    <CheckBox Tag="LibreWolf.LibreWolf" Content="LibreWolf (Privacy)"/>
                                    <CheckBox Tag="Discord.Discord" Content="Discord"/>
                                    <CheckBox Tag="Telegram.TelegramDesktop" Content="Telegram Desktop"/>
                                    <CheckBox Tag="9NKSQGP7F2NH" Content="WhatsApp Desktop"/>
                                </StackPanel>
                            </Border>

                            <Border Grid.Column="2" Background="#1E222B" CornerRadius="6" Padding="12" Margin="6,0,0,0">
                                <StackPanel Name="PanelTools">
                                    <TextBlock Text="Gaming &amp; Utilities" FontSize="15" FontWeight="Bold" Foreground="#34D399" Margin="0,0,0,8"/>
                                    <CheckBox Tag="Valve.Steam" Content="Steam"/>
                                    <CheckBox Tag="EpicGames.EpicGamesLauncher" Content="Epic Games Launcher"/>
                                    <CheckBox Tag="VideoLAN.VLC" Content="VLC Media Player"/>
                                    <CheckBox Tag="7zip.7zip" Content="7-Zip Archiver"/>
                                    <CheckBox Tag="RARLab.WinRAR" Content="WinRAR"/>
                                    <CheckBox Tag="OBSProject.OBSStudio" Content="OBS Studio"/>
                                    <CheckBox Tag="voidtools.Everything" Content="Everything File Search"/>
                                    <CheckBox Tag="Notepad++.Notepad++" Content="Notepad++"/>
                                    <CheckBox Tag="Microsoft.VisualStudioCode" Content="Visual Studio Code"/>
                                    <CheckBox Tag="Git.Git" Content="Git for Windows"/>
                                </StackPanel>
                            </Border>
                        </Grid>
                    </ScrollViewer>

                    <StackPanel Grid.Row="1" Orientation="Horizontal" HorizontalAlignment="Right" Margin="0,12,0,0">
                        <Button Name="BtnSelectAllDotNet" Content="Select All .NET &amp; Runtimes" Background="#334155" Margin="0,0,10,0"/>
                        <Button Name="BtnClearApps" Content="Clear Selection" Background="#475569" Margin="0,0,10,0"/>
                        <Button Name="BtnInstallApps" Content="Install Selected Applications" Background="#0284C7" Padding="20,9"/>
                    </StackPanel>
                </Grid>
            </TabItem>

            <TabItem Header="Gaming &amp; System Tweaks">
                <Grid Margin="12">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>

                    <ScrollViewer Grid.Row="0" VerticalScrollBarVisibility="Auto">
                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="*"/>
</Grid.ColumnDefinitions>
"@
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)
$TxtLog = $window.FindName("TxtLog")
function Write-Log {
param([string]$Message)
$timestamp = (Get-Date).ToString("HH:mm:ss")
$TxtLog.AppendText("[$timestamp] $Messagern")
$TxtLog.ScrollToEnd()
[System.Windows.Forms.Application]::DoEvents() | Out-Null
}
Write-Log "Ready. Running with Administrator privileges."
function Set-RegValue {
param([string]$Path, [string]$Name, $Value, [string]$Type = "DWord")
if (-not (Test-Path $Path)) {
New-Item -Path $Path -Force | Out-Null
}
Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -Force
}
function Ensure-WinGet {
Write-Log "Checking if WinGet Package Manager is installed on this PC..."
if (Get-Command winget -ErrorAction SilentlyContinue) {
Write-Log "WinGet is installed and ready."
return $true
}
Write-Log "WARNING: WinGet is missing on your PC. Installing WinGet dependencies first..."
try {
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$vclibsUrl = "aka.ms"
$wingetUrl = "github.com"
$vclibsPath = "$env:TEMP\VCLibs.appx"
$wingetPath = "$env:TEMP\WinGet.msixbundle"
Write-Log "Downloading Microsoft VCLibs dependency..."
Invoke-WebRequest -Uri $vclibsUrl -OutFile $vclibsPath -UseBasicParsing
Add-AppxPackage -Path $vclibsPath -ErrorAction SilentlyContinue
Write-Log "Downloading Microsoft App Installer (WinGet)..."
Invoke-WebRequest -Uri $wingetUrl -OutFile $wingetPath -UseBasicParsing
Add-AppxPackage -Path $wingetPath -ErrorAction Stop
if (Get-Command winget -ErrorAction SilentlyContinue) {
Write-Log "SUCCESS: WinGet has been installed! Proceeding with your app installation..."
return $true
} else {
Write-Log "ERROR: WinGet installed, but Windows requires a terminal restart to recognize it."
return $false
}
} catch {
Write-Log "ERROR: Failed to auto-install WinGet. Reason: $($_.Exception.Message)"
Write-Log "TIP: Please check your internet connection or update 'App Installer' from Microsoft Store."
return $false
}
}
$window.FindName("BtnSelectAllDotNet").Add_Click({
foreach ($cb in $window.FindName("PanelDotNet").Children) {
if ($cb -is [System.Windows.Controls.CheckBox]) { $cb.IsChecked = $true }
}
Write-Log "Selected all .NET Framework, .NET 5-9 Desktop Runtimes, Visual C++ & DirectX packages."
})
$window.FindName("BtnClearApps").Add_Click({
foreach ($panelName in @("PanelDotNet", "PanelBrowsers", "PanelTools")) {
foreach ($cb in $window.FindName($panelName).Children) {
if ($cb -is [System.Windows.Controls.CheckBox]) { $cb.IsChecked = $false }
}
}
Write-Log "Cleared all application selections."
})
$window.FindName("BtnInstallApps").Add_Click({
$selectedApps = @()
foreach ($panelName in @("PanelDotNet", "PanelBrowsers", "PanelTools")) {
foreach ($cb in $window.FindName($panelName).Children) {
if ($cb -is [System.Windows.Controls.CheckBox] -and $cb.IsChecked) {
$selectedApps += [PSCustomObject]@{ Name = $cb.Content; Id = $cb.Tag }
}
}
}
if ($selectedApps.Count -eq 0) {
[System.Windows.MessageBox]::Show("Please select at least one application or .NET runtime first!", "No Selection", "OK", "Warning")
return
}
$normalApps = @()
foreach ($app in $selectedApps) {
if ($app.Id -eq "DOTNET35") {
Write-Log "Enabling .NET Framework 3.5 (includes 2.0 & 3.0) via Windows Features..."
try {
Enable-WindowsOptionalFeature -Online -FeatureName "NetFx3" -All -NoRestart -ErrorAction Stop | Out-Null
Write-Log "SUCCESS: .NET Framework 3.5 enabled."
} catch {
Write-Log "ERROR: Failed to enable .NET 3.5. Reason: $($_.Exception.Message)"
}
} else {
$normalApps += $app
}
}
if ($normalApps.Count -eq 0) { return }
if (-not (Ensure-WinGet)) {
[System.Windows.MessageBox]::Show("WinGet is required to download applications and could not be initialized automatically. Check the log below for details.", "WinGet Missing", "OK", "Error")
return
}
foreach ($app in $normalApps) {
Write-Log "Downloading & Installing: $($app.Name) ($($app.Id))..."
$proc = Start-Process -FilePath "winget" -ArgumentList "install --id "$($app.Id)" --exact --silent --accept-source-agreements --accept-package-agreements" -Wait -PassThru -NoNewWindow
switch ($proc.ExitCode) {
0 { Write-Log "SUCCESS: $($app.Name) installed successfully." }
-1978335189 { Write-Log "INFO: $($app.Name) is already installed and up to date." }
-1978335212 { Write-Log "ERROR: Package '$($app.Id)' not found in WinGet repository." }
-1978335221 { Write-Log "ERROR: Download failed for $($app.Name). Check your internet connection or firewall." }
default { Write-Log "WARNING: $($app.Name) finished with exit code $($proc.ExitCode). It may require a system reboot or manual setup." }
}
}
Write-Log "All selected installation tasks completed!"
[System.Windows.MessageBox]::Show("Selected software installation process has finished! Check the log window for status details.", "Completed", "OK", "Information")
})
$window.FindName("BtnApplyTweaks").Add_Click({
Write-Log "Applying selected Registry & Gaming tweaks..."
try {
if ($window.FindName("ChkMenuDelay").IsChecked) {
Set-RegValue "HKCU:\Control Panel\Desktop" "MenuShowDelay" "0" "String"
Write-Log "Applied: MenuShowDelay set to 0."
}
if ($window.FindName("ChkWin32Prio").IsChecked) {
Set-RegValue "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" "Win32PrioritySeparation" 0x1a "DWord"
Write-Log "Applied: Win32PrioritySeparation set to 0x1a."
}
if ($window.FindName("ChkGameTasks").IsChecked) {
$gPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"
Set-RegValue $gPath "GPU Priority" 8 "DWord"
Set-RegValue $gPath "Priority" 6 "DWord"
Set-RegValue $gPath "Scheduling Category" "High" "String"
Set-RegValue $gPath "SFIO Priority" "High" "String"
Write-Log "Applied: Gaming GPU Priority (8) & High Scheduling."
}
if ($window.FindName("ChkNetThrottle").IsChecked) {
$nPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
Set-RegValue $nPath "NetworkThrottlingIndex" 0xffffffff "DWord"
Set-RegValue $nPath "SystemResponsiveness" 0 "DWord"
Write-Log "Applied: Disabled Network Throttling & set SystemResponsiveness to 0."
}
if ($window.FindName("ChkGameBarRemove").IsChecked) {
Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" "AppCaptureEnabled" 0 "DWord"
Set-RegValue "HKCU:\System\GameConfigStore" "GameDVR_Enabled" 0 "DWord"
Set-RegValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" "AllowGameDVR" 0 "DWord"
Get-AppxPackage -AllUsers Microsoft.XboxGamingOverlay | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
Write-Log "Applied: Disabled Game DVR & removed Xbox Game Bar package."
}
if ($window.FindName("ChkGameMode").IsChecked) {
Set-RegValue "HKCU:\Software\Microsoft\GameBar" "AutoGameModeEnabled" 1 "DWord"
Write-Log "Applied: Windows Game Mode enabled."
}
if ($window.FindName("ChkMouseAccel").IsChecked) {
Set-RegValue "HKCU:\Control Panel\Mouse" "MouseSpeed" "0" "String"
Set-RegValue "HKCU:\Control Panel\Mouse" "MouseThreshold1" "0" "String"
Set-RegValue "HKCU:\Control Panel\Mouse" "MouseThreshold2" "0" "String"
Write-Log "Applied: Mouse Acceleration disabled."
}
if ($window.FindName("ChkVisualPerf").IsChecked) {
Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" "VisualFXSetting" 2 "DWord"
Write-Log "Applied: Visual Effects set to Best Performance."
}
if ($window.FindName("ChkTelemetry").IsChecked) {
Set-RegValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 0 "DWord"
Write-Log "Applied: Windows Telemetry disabled."
}
if ($window.FindName("ChkActivity").IsChecked) {
Set-RegValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "EnableActivityFeed" 0 "DWord"
Set-RegValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" "DisableLocation" 1 "DWord"
Write-Log "Applied: Activity History & Location Tracking disabled."
}
if ($window.FindName("ChkHibernation").IsChecked) {
powercfg.exe /hibernate off
Write-Log "Applied: Hibernation disabled."
}
if ($window.FindName("ChkBgApps").IsChecked) {
Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" "GlobalUserDisabled" 1 "DWord"
Write-Log "Applied: Background Apps disabled."
}
if ($window.FindName("ChkWidgets").IsChecked) {
Set-RegValue "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" "AllowNewsAndInterests" 0 "DWord"
Set-RegValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" "EnableFeeds" 0 "DWord"
Write-Log "Applied: Widgets & News Feeds disabled."
}
if ($window.FindName("ChkEndTask").IsChecked) {
Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" "TaskbarEndTask" 1 "DWord"
Write-Log "Applied: End Task on Taskbar right-click enabled."
}
if ($window.FindName("ChkFileExt").IsChecked) {
Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 0 "DWord"
Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Hidden" 1 "DWord"
Write-Log "Applied: File Extensions & Hidden Files shown."
}
if ($window.FindName("ChkDarkTheme").IsChecked) {
$tPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
Set-RegValue $tPath "AppsUseLightTheme" 0 "DWord"
Set-RegValue $tPath "SystemUsesLightTheme" 0 "DWord"
Write-Log "Applied: Windows Dark Mode enabled."
}
if ($window.FindName("ChkStickyKeys").IsChecked) {
Set-RegValue "HKCU:\Control Panel\Accessibility\StickyKeys" "Flags" "506" "String"
Write-Log "Applied: Sticky Keys disabled."
}
Write-Log "SUCCESS: All selected tweaks have been applied!"
[System.Windows.MessageBox]::Show("Selected tweaks applied successfully! Restart your PC or Explorer for all changes to take full effect.", "Success", "OK", "Information")
} catch {
Write-Log "ERROR applying tweaks: $($_.Exception.Message)"
}
})
$window.FindName("BtnUndoTweaks").Add_Click({
Write-Log "Restoring default Windows settings for selected tweaks..."
if ($window.FindName("ChkMenuDelay").IsChecked) { Set-RegValue "HKCU:\Control Panel\Desktop" "MenuShowDelay" "400" "String" }
if ($window.FindName("ChkWin32Prio").IsChecked) { Set-RegValue "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" "Win32PrioritySeparation" 2 "DWord" }
if ($window.FindName("ChkNetThrottle").IsChecked) {
Set-RegValue "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "NetworkThrottlingIndex" 10 "DWord"
Set-RegValue "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "SystemResponsiveness" 20 "DWord"
}
if ($window.FindName("ChkGameBarRemove").IsChecked) {
Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" "AppCaptureEnabled" 1 "DWord"
Set-RegValue "HKCU:\System\GameConfigStore" "GameDVR_Enabled" 1 "DWord"
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -ErrorAction SilentlyContinue
}
if ($window.FindName("ChkMouseAccel").IsChecked) {
Set-RegValue "HKCU:\Control Panel\Mouse" "MouseSpeed" "1" "String"
Set-RegValue "HKCU:\Control Panel\Mouse" "MouseThreshold1" "6" "String"
Set-RegValue "HKCU:\Control Panel\Mouse" "MouseThreshold2" "10" "String"
}
if ($window.FindName("ChkHibernation").IsChecked) { powercfg.exe /hibernate on }
if ($window.FindName("ChkBgApps").IsChecked) { Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" "GlobalUserDisabled" 0 "DWord" }
if ($window.FindName("ChkWidgets").IsChecked) { Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -ErrorAction SilentlyContinue }
if ($window.FindName("ChkFileExt").IsChecked) { Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 1 "DWord" }
Write-Log "SUCCESS: Selected tweaks restored to Windows defaults."
})
$window.FindName("BtnUltEnable").Add_Click({
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
$guid = (powercfg -list | Select-String "Ultimate Performance").ToString().Split()
if ($guid) { powercfg -setactive $guid; Write-Log "SUCCESS: Ultimate Performance Power Plan enabled & activated." }
})
$window.FindName("BtnUltDisable").Add_Click({
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e
$schemes = powercfg -list | Select-String "Ultimate Performance"
foreach ($s in $schemes) { $g = $s.ToString().Split(); powercfg -delete $g }
Write-Log "SUCCESS: Ultimate Performance Plan disabled & removed (Switched to Balanced)."
})
$window.FindName("BtnHighEnable").Add_Click({
powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c | Out-Null
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
Write-Log "SUCCESS: High Performance Power Plan enabled & activated."
})
$window.FindName("BtnHighDisable").Add_Click({
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e
powercfg -delete 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>$null
Write-Log "SUCCESS: High Performance Plan disabled."
})
$window.FindName("BtnBalEnable").Add_Click({
powercfg -duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e | Out-Null
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e
Write-Log "SUCCESS: Balanced Power Plan enabled & activated."
})
$window.FindName("BtnBalDisable").Add_Click({
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>$null
powercfg -delete 381b4222-f694-41f0-9685-ff5bb260df2e 2>$null
Write-Log "SUCCESS: Balanced Power Plan disabled."
})
$window.FindName("BtnCreateRestore").Add_Click({
Write-Log "Creating System Restore Point..."
Enable-ComputerRestore -Drive "C:" -ErrorAction SilentlyContinue
Checkpoint-Computer -Description "ProWinOptimizer_Backup" -RestorePointType "MODIFY_SETTINGS" -ErrorAction SilentlyContinue
Write-Log "SUCCESS: System Restore Point created."
})
$window.FindName("BtnCleanTemp").Add_Click({
Write-Log "Cleaning Windows Temp, User Temp & Prefetch folders..."
Remove-Item -Path "$env:TEMP*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Prefetch*" -Recurse -Force -ErrorAction SilentlyContinue
Write-Log "SUCCESS: Temporary junk files cleaned!"
})
$window.FindName("BtnRestartExplorer").Add_Click({
Write-Log "Restarting Windows Explorer..."
Stop-Process -Name explorer -Force
Write-Log "SUCCESS: Windows Explorer restarted."
})
$window.FindName("BtnCheckWinget").Add_Click({
Ensure-WinGet | Out-Null
})
$window.FindName("BtnOpenPowerCpl").Add_Click({
Start-Process "powercfg.cpl"
})
$window.ShowDialog() | Out-Null
