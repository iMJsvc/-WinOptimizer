if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Windows.Forms

function New-Brush($hex) {
    return (New-Object System.Windows.Media.BrushConverter).ConvertFromString($hex)
}

$win = New-Object System.Windows.Window
$win.Title = "Pro Windows Optimizer & App Installer v1.0"
$win.Width = 1020
$win.Height = 730
$win.WindowStartupLocation = "CenterScreen"
$win.Background = New-Brush "#121418"
$win.Foreground = New-Brush "#EAEAEA"
$win.FontFamily = New-Object System.Windows.Media.FontFamily("Segoe UI")

$mainGrid = New-Object System.Windows.Controls.Grid
$mainGrid.Margin = "15"
$r0 = New-Object System.Windows.Controls.RowDefinition; $r0.Height = "Auto"
$r1 = New-Object System.Windows.Controls.RowDefinition; $r1.Height = "*"
$r2 = New-Object System.Windows.Controls.RowDefinition; $r2.Height = "155"
$mainGrid.RowDefinitions.Add($r0)
$mainGrid.RowDefinitions.Add($r1)
$mainGrid.RowDefinitions.Add($r2)

# HEADER
$headerBorder = New-Object System.Windows.Controls.Border
$headerBorder.Background = New-Brush "#1A1D24"
$headerBorder.CornerRadius = "8"
$headerBorder.Padding = "15"
$headerBorder.Margin = "0,0,0,12"
$headerBorder.BorderBrush = New-Brush "#2A2F3A"
$headerBorder.BorderThickness = "1"
[System.Windows.Controls.Grid]::SetRow($headerBorder, 0)

$dock = New-Object System.Windows.Controls.DockPanel
$titleStack = New-Object System.Windows.Controls.StackPanel
$t1 = New-Object System.Windows.Controls.TextBlock
$t1.Text = "PRO WINDOWS OPTIMIZER & SMART INSTALLER"
$t1.FontSize = 20
$t1.FontWeight = "Bold"
$t1.Foreground = New-Brush "#38BDF8"
$t2 = New-Object System.Windows.Controls.TextBlock
$t2.Text = "All-in-One Gaming Tweaks, Power Plans, .NET Runtimes & Automated Software Setup"
$t2.FontSize = 12
$t2.Foreground = New-Brush "#94A3B8"
$titleStack.Children.Add($t1) | Out-Null
$titleStack.Children.Add($t2) | Out-Null

$BtnCreateRestore = New-Object System.Windows.Controls.Button
$BtnCreateRestore.Content = "Create Restore Point"
$BtnCreateRestore.HorizontalAlignment = "Right"
$BtnCreateRestore.Background = New-Brush "#10B981"
$BtnCreateRestore.Foreground = New-Brush "#FFFFFF"
$BtnCreateRestore.FontWeight = "SemiBold"
$BtnCreateRestore.Padding = "14,8"
$BtnCreateRestore.BorderThickness = "0"

$dock.Children.Add($titleStack) | Out-Null
$dock.Children.Add($BtnCreateRestore) | Out-Null
$headerBorder.Child = $dock
$mainGrid.Children.Add($headerBorder) | Out-Null

# TAB CONTROL
$tabs = New-Object System.Windows.Controls.TabControl
$tabs.Background = New-Brush "#181B22"
$tabs.BorderBrush = New-Brush "#2D333F"
$tabs.BorderThickness = "1"
[System.Windows.Controls.Grid]::SetRow($tabs, 1)

function New-StyledButton($text, $bgHex) {
    $b = New-Object System.Windows.Controls.Button
    $b.Content = $text
    $b.Background = New-Brush $bgHex
    $b.Foreground = New-Brush "#FFFFFF"
    $b.FontWeight = "SemiBold"
    $b.FontSize = 13
    $b.Padding = "14,8"
    $b.BorderThickness = "0"
    $b.Margin = "0,0,8,0"
    return $b
}

function New-AppCheck($panel, $tag, $label) {
    $cb = New-Object System.Windows.Controls.CheckBox
    $cb.Tag = $tag
    $cb.Content = $label
    $cb.Foreground = New-Brush "#E2E8F0"
    $cb.FontSize = 13
    $cb.Margin = "0,4"
    $panel.Children.Add($cb) | Out-Null
    return $cb
}

function New-TweakCheck($panel, $label) {
    $cb = New-Object System.Windows.Controls.CheckBox
    $cb.Content = $label
    $cb.Foreground = New-Brush "#E2E8F0"
    $cb.FontSize = 13
    $cb.Margin = "0,4"
    $panel.Children.Add($cb) | Out-Null
    return $cb
}

# ==================== TAB 1: APPS & .NET ====================
$tab1 = New-Object System.Windows.Controls.TabItem
$tab1.Header = "  Install Apps & .NET  "
$g1 = New-Object System.Windows.Controls.Grid; $g1.Margin = "12"
$g1r0 = New-Object System.Windows.Controls.RowDefinition; $g1r0.Height = "*"
$g1r1 = New-Object System.Windows.Controls.RowDefinition; $g1r1.Height = "Auto"
$g1.RowDefinitions.Add($g1r0); $g1.RowDefinitions.Add($g1r1)

$sv1 = New-Object System.Windows.Controls.ScrollViewer
$sv1.VerticalScrollBarVisibility = "Auto"
[System.Windows.Controls.Grid]::SetRow($sv1, 0)

$colsGrid1 = New-Object System.Windows.Controls.Grid
for ($i=0; $i -lt 3; $i++) {
    $cd = New-Object System.Windows.Controls.ColumnDefinition; $cd.Width = "*"
    $colsGrid1.ColumnDefinitions.Add($cd)
}

function New-CardPanel($parentGrid, $colIdx, $heading, $colorHex) {
    $b = New-Object System.Windows.Controls.Border
    $b.Background = New-Brush "#1E222B"
    $b.CornerRadius = "6"
    $b.Padding = "12"
    $b.Margin = "4"
    [System.Windows.Controls.Grid]::SetColumn($b, $colIdx)
    $sp = New-Object System.Windows.Controls.StackPanel
    $lbl = New-Object System.Windows.Controls.TextBlock
    $lbl.Text = $heading
    $lbl.FontSize = 15
    $lbl.FontWeight = "Bold"
    $lbl.Foreground = New-Brush $colorHex
    $lbl.Margin = "0,0,0,8"
    $sp.Children.Add($lbl) | Out-Null
    $b.Child = $sp
    $parentGrid.Children.Add($b) | Out-Null
    return $sp
}

$PanelDotNet = New-CardPanel $colsGrid1 0 ".NET Framework & Runtimes" "#38BDF8"
New-AppCheck $PanelDotNet "DOTNET35" ".NET Framework 3.5 (Includes 2.0 & 3.0)" | Out-Null
New-AppCheck $PanelDotNet "Microsoft.DotNet.Framework.DeveloperPack_4" ".NET Framework 4.8 Developer Pack" | Out-Null
New-AppCheck $PanelDotNet "Microsoft.DotNet.DesktopRuntime.5" ".NET 5.0 Desktop Runtime" | Out-Null
New-AppCheck $PanelDotNet "Microsoft.DotNet.DesktopRuntime.6" ".NET 6.0 Desktop Runtime" | Out-Null
New-AppCheck $PanelDotNet "Microsoft.DotNet.DesktopRuntime.7" ".NET 7.0 Desktop Runtime" | Out-Null
New-AppCheck $PanelDotNet "Microsoft.DotNet.DesktopRuntime.8" ".NET 8.0 Desktop Runtime (LTS)" | Out-Null
New-AppCheck $PanelDotNet "Microsoft.DotNet.DesktopRuntime.9" ".NET 9.0 Desktop Runtime" | Out-Null
New-AppCheck $PanelDotNet "Microsoft.VCRedist.2015+.x64" "Visual C++ 2015-2022 Redist (x64)" | Out-Null
New-AppCheck $PanelDotNet "Microsoft.VCRedist.2015+.x86" "Visual C++ 2015-2022 Redist (x86)" | Out-Null
New-AppCheck $PanelDotNet "Microsoft.DirectX" "DirectX End-User Runtime" | Out-Null

$PanelBrowsers = New-CardPanel $colsGrid1 1 "Browsers & Communication" "#A78BFA"
New-AppCheck $PanelBrowsers "Google.Chrome" "Google Chrome" | Out-Null
New-AppCheck $PanelBrowsers "Brave.Brave" "Brave Browser" | Out-Null
New-AppCheck $PanelBrowsers "Mozilla.Firefox" "Mozilla Firefox" | Out-Null
New-AppCheck $PanelBrowsers "Zen-Team.Zen-Browser" "Zen Browser" | Out-Null
New-AppCheck $PanelBrowsers "LibreWolf.LibreWolf" "LibreWolf (Privacy)" | Out-Null
New-AppCheck $PanelBrowsers "Discord.Discord" "Discord" | Out-Null
New-AppCheck $PanelBrowsers "Telegram.TelegramDesktop" "Telegram Desktop" | Out-Null
New-AppCheck $PanelBrowsers "9NKSQGP7F2NH" "WhatsApp Desktop" | Out-Null

$PanelTools = New-CardPanel $colsGrid1 2 "Gaming & Essential Utilities" "#34D399"
New-AppCheck $PanelTools "Valve.Steam" "Steam" | Out-Null
New-AppCheck $PanelTools "EpicGames.EpicGamesLauncher" "Epic Games Launcher" | Out-Null
New-AppCheck $PanelTools "VideoLAN.VLC" "VLC Media Player" | Out-Null
New-AppCheck $PanelTools "7zip.7zip" "7-Zip Archiver" | Out-Null
New-AppCheck $PanelTools "RARLab.WinRAR" "WinRAR" | Out-Null
New-AppCheck $PanelTools "OBSProject.OBSStudio" "OBS Studio" | Out-Null
New-AppCheck $PanelTools "voidtools.Everything" "Everything File Search" | Out-Null
New-AppCheck $PanelTools "Notepad++.Notepad++" "Notepad++" | Out-Null
New-AppCheck $PanelTools "Microsoft.VisualStudioCode" "Visual Studio Code" | Out-Null
New-AppCheck $PanelTools "Git.Git" "Git for Windows" | Out-Null

$sv1.Content = $colsGrid1
$g1.Children.Add($sv1) | Out-Null

$btnBar1 = New-Object System.Windows.Controls.StackPanel
$btnBar1.Orientation = "Horizontal"
$btnBar1.HorizontalAlignment = "Right"
$btnBar1.Margin = "0,10,0,0"
[System.Windows.Controls.Grid]::SetRow($btnBar1, 1)

$BtnSelectAllDotNet = New-StyledButton "Select All .NET & Runtimes" "#334155"
$BtnClearApps = New-StyledButton "Clear Selection" "#475569"
$BtnInstallApps = New-StyledButton "Install Selected Applications" "#0284C7"
$btnBar1.Children.Add($BtnSelectAllDotNet) | Out-Null
$btnBar1.Children.Add($BtnClearApps) | Out-Null
$btnBar1.Children.Add($BtnInstallApps) | Out-Null
$g1.Children.Add($btnBar1) | Out-Null
$tab1.Content = $g1
$tabs.Items.Add($tab1) | Out-Null

# ==================== TAB 2: GAMING & SYSTEM TWEAKS ====================
$tab2 = New-Object System.Windows.Controls.TabItem
$tab2.Header = "  Gaming & System Tweaks  "
$g2 = New-Object System.Windows.Controls.Grid; $g2.Margin = "12"
$g2r0 = New-Object System.Windows.Controls.RowDefinition; $g2r0.Height = "*"
$g2r1 = New-Object System.Windows.Controls.RowDefinition; $g2r1.Height = "Auto"
$g2.RowDefinitions.Add($g2r0); $g2.RowDefinitions.Add($g2r1)

$sv2 = New-Object System.Windows.Controls.ScrollViewer
$sv2.VerticalScrollBarVisibility = "Auto"
[System.Windows.Controls.Grid]::SetRow($sv2, 0)

$colsGrid2 = New-Object System.Windows.Controls.Grid
for ($i=0; $i -lt 2; $i++) {
    $cd = New-Object System.Windows.Controls.ColumnDefinition; $cd.Width = "*"
    $colsGrid2.ColumnDefinitions.Add($cd)
}

$PanelGaming = New-CardPanel $colsGrid2 0 "Gaming & Latency Optimizations" "#F59E0B"
$ChkMenuDelay = New-TweakCheck $PanelGaming "Instant Menu Show Speed (MenuShowDelay = 0)"
$ChkWin32Prio = New-TweakCheck $PanelGaming "Optimize CPU Foreground Priority (Win32Priority = 0x1a)"
$ChkGameTasks = New-TweakCheck $PanelGaming "Boost Gaming GPU & CPU Scheduling (High Priority)"
$ChkNetThrottle = New-TweakCheck $PanelGaming "Disable Network Throttling & 0% System Reservation"
$ChkGameBarRemove = New-TweakCheck $PanelGaming "Disable & Completely Remove Xbox Game Bar + Game DVR"
$ChkGameMode = New-TweakCheck $PanelGaming "Enable Windows Game Mode"
$ChkMouseAccel = New-TweakCheck $PanelGaming "Disable Mouse Acceleration (1:1 Raw Input)"
$ChkVisualPerf = New-TweakCheck $PanelGaming "Set Visual Effects to Best Performance"
$PanelSystem = New-CardPanel $colsGrid2 1 "Essential System & Privacy Tweaks" "#38BDF8"
$ChkTelemetry = New-TweakCheck $PanelSystem "Disable Windows Telemetry & Data Collection"
$ChkActivity = New-TweakCheck $PanelSystem "Disable Activity History & Location Tracking"
$ChkHibernation = New-TweakCheck $PanelSystem "Disable Hibernation (Frees up several GBs of C: drive)"
$ChkBgApps = New-TweakCheck $PanelSystem "Disable Background Apps"
$ChkWidgets = New-TweakCheck $PanelSystem "Disable Windows Widgets & Consumer Features"
$ChkEndTask = New-TweakCheck $PanelSystem "Enable 'End Task' on Taskbar Right-Click (Win 11)"
$ChkFileExt = New-TweakCheck $PanelSystem "Show File Extensions & Hidden Files in Explorer"
$ChkDarkTheme = New-TweakCheck $PanelSystem "Enable System-Wide Dark Mode"
$ChkStickyKeys = New-TweakCheck $PanelSystem "Disable Sticky Keys Prompt"
$sv2.Content = $colsGrid2
$g2.Children.Add($sv2) | Out-Null
$btnBar2 = New-Object System.Windows.Controls.StackPanel
$btnBar2.Orientation = "Horizontal"
$btnBar2.HorizontalAlignment = "Right"
$btnBar2.Margin = "0,10,0,0"
[System.Windows.Controls.Grid]::SetRow($btnBar2, 1)
$BtnUndoTweaks = New-StyledButton "Restore Defaults (Undo Selected)" "#DC2626"
$BtnApplyTweaks = New-StyledButton "Apply Selected Tweaks" "#16A34A"
$btnBar2.Children.Add($BtnUndoTweaks) | Out-Null
$btnBar2.Children.Add($BtnApplyTweaks) | Out-Null
$g2.Children.Add($btnBar2) | Out-Null
$tab2.Content = $g2
$tabs.Items.Add($tab2) | Out-Null

==================== TAB 3: POWER PLANS & MAINTENANCE ====================

$tab3 = New-Object System.Windows.Controls.TabItem
$tab3.Header = "  Power Plans & Maintenance  "
$g3 = New-Object System.Windows.Controls.Grid; $g3.Margin = "15"
for ($i=0; $i -lt 2; $i++) {
$cd = New-Object System.Windows.Controls.ColumnDefinition; $cd.Width = "*"
$g3.ColumnDefinitions.Add($cd)
}
$PanelPower = New-CardPanel $g3 0 "Windows Power Plans Control" "#38BDF8"
function Add-PowerRow($parent, $title, $enableColor) {
$lbl = New-Object System.Windows.Controls.TextBlock
$lbl.Text = $title; $lbl.FontWeight = "SemiBold"; $lbl.Margin = "0,8,0,6"
$parent.Children.Add($lbl) | Out-Null
$row = New-Object System.Windows.Controls.StackPanel
$row.Orientation = "Horizontal"; $row.Margin = "0,0,0,10"
$b1 = New-StyledButton "Enable & Activate" $enableColor
$b2 = New-StyledButton "Disable / Delete" "#DC2626"
$row.Children.Add($b1) | Out-Null
$row.Children.Add($b2) | Out-Null
$parent.Children.Add($row) | Out-Null
return @($b1, $b2)
}
$ultBtns = Add-PowerRow $PanelPower "1. Ultimate Performance Plan (Best for Desktop/Gaming)" "#16A34A"
$highBtns = Add-PowerRow $PanelPower "2. High Performance Plan" "#0284C7"
$balBtns = Add-PowerRow $PanelPower "3. Balanced Power Plan (Recommended for Laptops)" "#0D9488"
$PanelMaint = New-CardPanel $g3 1 "System Maintenance & Quick Fixes" "#F59E0B"
$BtnCleanTemp = New-StyledButton "Clean Temporary & Prefetch Files" "#334155"; $BtnCleanTemp.Margin = "0,6,0,10"
$BtnRestartExplorer = New-StyledButton "Restart Windows Explorer (Apply UI Tweaks)" "#334155"; $BtnRestartExplorer.Margin = "0,0,0,10"
$BtnCheckWinget = New-StyledButton "Verify / Repair WinGet Package Manager" "#0284C7"; $BtnCheckWinget.Margin = "0,0,0,10"
$BtnOpenPowerCpl = New-StyledButton "Open Classic Windows Power Options" "#475569"; $BtnOpenPowerCpl.Margin = "0,0,0,10"
$PanelMaint.Children.Add($BtnCleanTemp) | Out-Null
$PanelMaint.Children.Add($BtnRestartExplorer) | Out-Null
$PanelMaint.Children.Add($BtnCheckWinget) | Out-Null
$PanelMaint.Children.Add($BtnOpenPowerCpl) | Out-Null
$tab3.Content = $g3
$tabs.Items.Add($tab3) | Out-Null
$mainGrid.Children.Add($tabs) | Out-Null

LIVE LOG CONSOLE

$logBorder = New-Object System.Windows.Controls.Border
$logBorder.Background = New-Brush "#0D0F12"
$logBorder.CornerRadius = "6"
$logBorder.Padding = "10"
$logBorder.Margin = "0,12,0,0"
$logBorder.BorderBrush = New-Brush "#2D333F"
$logBorder.BorderThickness = "1"
[System.Windows.Controls.Grid]::SetRow($logBorder, 2)
$logGrid = New-Object System.Windows.Controls.Grid
$lr0 = New-Object System.Windows.Controls.RowDefinition; $lr0.Height = "Auto"
$lr1 = New-Object System.Windows.Controls.RowDefinition; $lr1.Height = "*"
$logGrid.RowDefinitions.Add($lr0); $logGrid.RowDefinitions.Add($lr1)
$logHeader = New-Object System.Windows.Controls.TextBlock
$logHeader.Text = "LIVE SYSTEM LOG & DIAGNOSTICS:"
$logHeader.FontSize = 11; $logHeader.FontWeight = "Bold"
$logHeader.Foreground = New-Brush "#64748B"; $logHeader.Margin = "0,0,0,4"
[System.Windows.Controls.Grid]::SetRow($logHeader, 0)
$TxtLog = New-Object System.Windows.Controls.TextBox
$TxtLog.Background = New-Brush "#0D0F12"
$TxtLog.Foreground = New-Brush "#10B981"
$TxtLog.BorderThickness = "0"
$TxtLog.FontFamily = New-Object System.Windows.Media.FontFamily("Consolas")
$TxtLog.FontSize = 12
$TxtLog.IsReadOnly = $true
$TxtLog.VerticalScrollBarVisibility = "Auto"
$TxtLog.TextWrapping = "Wrap"
[System.Windows.Controls.Grid]::SetRow($TxtLog, 1)
$logGrid.Children.Add($logHeader) | Out-Null
$logGrid.Children.Add($TxtLog) | Out-Null
$logBorder.Child = $logGrid
$mainGrid.Children.Add($logBorder) | Out-Null
$win.Content = $mainGrid

==================== LOGIC & FUNCTIONS ====================

function Write-Log([string]$Message) {
$ts = (Get-Date).ToString("HH:mm:ss")
$TxtLog.AppendText("[$ts] $Messagern")
$TxtLog.ScrollToEnd()
[System.Windows.Forms.Application]::DoEvents() | Out-Null
}
Write-Log "Ready. Running with Administrator privileges."
function Set-RegValue([string]$Path, [string]$Name, $Value, [string]$Type = "DWord") {
if (-not (Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
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
$proto = "https:" + "//"
$vclibsUrl = $proto + "aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
$wingetUrl = $proto + "github.com"
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
Write-Log "TIP: Check your internet connection or update 'App Installer' from Microsoft Store."
return $false
}
}
$BtnSelectAllDotNet.Add_Click({
foreach ($cb in $PanelDotNet.Children) {
if ($cb -is [System.Windows.Controls.CheckBox]) { $cb.IsChecked = $true }
}
Write-Log "Selected all .NET Framework, .NET 5-9 Desktop Runtimes, Visual C++ & DirectX packages."
})
$BtnClearApps.Add_Click({
foreach ($p in @($PanelDotNet, $PanelBrowsers, $PanelTools)) {
foreach ($cb in $p.Children) {
if ($cb -is [System.Windows.Controls.CheckBox]) { $cb.IsChecked = $false }
}
}
Write-Log "Cleared all application selections."
})
$BtnInstallApps.Add_Click({
$selectedApps = @()
foreach ($p in @($PanelDotNet, $PanelBrowsers, $PanelTools)) {
foreach ($cb in $p.Children) {
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
default { Write-Log "WARNING: $($app.Name) finished with exit code $($proc.ExitCode)." }
}
}
Write-Log "All selected installation tasks completed!"
[System.Windows.MessageBox]::Show("Selected software installation process has finished!", "Completed", "OK", "Information")
})
$BtnApplyTweaks.Add_Click({
Write-Log "Applying selected Registry & Gaming tweaks..."
try {
if ($ChkMenuDelay.IsChecked) { Set-RegValue "HKCU:\Control Panel\Desktop" "MenuShowDelay" "0" "String"; Write-Log "Applied: MenuShowDelay set to 0." }
if ($ChkWin32Prio.IsChecked) { Set-RegValue "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" "Win32PrioritySeparation" 0x1a "DWord"; Write-Log "Applied: Win32PrioritySeparation set to 0x1a." }
if ($ChkGameTasks.IsChecked) {
$gPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"
Set-RegValue $gPath "GPU Priority" 8 "DWord"
Set-RegValue $gPath "Priority" 6 "DWord"
Set-RegValue $gPath "Scheduling Category" "High" "String"
Set-RegValue $gPath "SFIO Priority" "High" "String"
Write-Log "Applied: Gaming GPU Priority (8) & High Scheduling."
}
if ($ChkNetThrottle.IsChecked) {
$nPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
Set-RegValue $nPath "NetworkThrottlingIndex" 0xffffffff "DWord"
Set-RegValue $nPath "SystemResponsiveness" 0 "DWord"
Write-Log "Applied: Disabled Network Throttling & set SystemResponsiveness to 0."
}
if ($ChkGameBarRemove.IsChecked) {
Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" "AppCaptureEnabled" 0 "DWord"
Set-RegValue "HKCU:\System\GameConfigStore" "GameDVR_Enabled" 0 "DWord"
Set-RegValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" "AllowGameDVR" 0 "DWord"
Get-AppxPackage -AllUsers Microsoft.XboxGamingOverlay | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
Write-Log "Applied: Disabled Game DVR & removed Xbox Game Bar package."
}
if ($ChkGameMode.IsChecked) { Set-RegValue "HKCU:\Software\Microsoft\GameBar" "AutoGameModeEnabled" 1 "DWord"; Write-Log "Applied: Windows Game Mode enabled." }
if ($ChkMouseAccel.IsChecked) {
Set-RegValue "HKCU:\Control Panel\Mouse" "MouseSpeed" "0" "String"
Set-RegValue "HKCU:\Control Panel\Mouse" "MouseThreshold1" "0" "String"
Set-RegValue "HKCU:\Control Panel\Mouse" "MouseThreshold2" "0" "String"
Write-Log "Applied: Mouse Acceleration disabled."
}
if ($ChkVisualPerf.IsChecked) { Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" "VisualFXSetting" 2 "DWord"; Write-Log "Applied: Visual Effects set to Best Performance." }
if ($ChkTelemetry.IsChecked) { Set-RegValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 0 "DWord"; Write-Log "Applied: Windows Telemetry disabled." }
if ($ChkActivity.IsChecked) {
Set-RegValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "EnableActivityFeed" 0 "DWord"
Set-RegValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" "DisableLocation" 1 "DWord"
Write-Log "Applied: Activity History & Location Tracking disabled."
}
if ($ChkHibernation.IsChecked) { powercfg.exe /hibernate off; Write-Log "Applied: Hibernation disabled." }
if ($ChkBgApps.IsChecked) { Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" "GlobalUserDisabled" 1 "DWord"; Write-Log "Applied: Background Apps disabled." }
if ($ChkWidgets.IsChecked) {
Set-RegValue "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" "AllowNewsAndInterests" 0 "DWord"
Set-RegValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" "EnableFeeds" 0 "DWord"
Write-Log "Applied: Widgets & News Feeds disabled."
}
if ($ChkEndTask.IsChecked) { Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" "TaskbarEndTask" 1 "DWord"; Write-Log "Applied: End Task on Taskbar right-click enabled." }
if ($ChkFileExt.IsChecked) {
Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 0 "DWord"
Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Hidden" 1 "DWord"
Write-Log "Applied: File Extensions & Hidden Files shown."
}
if ($ChkDarkTheme.IsChecked) {
$tPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
Set-RegValue $tPath "AppsUseLightTheme" 0 "DWord"
Set-RegValue $tPath "SystemUsesLightTheme" 0 "DWord"
Write-Log "Applied: Windows Dark Mode enabled."
}
if ($ChkStickyKeys.IsChecked) { Set-RegValue "HKCU:\Control Panel\Accessibility\StickyKeys" "Flags" "506" "String"; Write-Log "Applied: Sticky Keys disabled." }
Write-Log "SUCCESS: All selected tweaks have been applied!"
[System.Windows.MessageBox]::Show("Selected tweaks applied successfully!", "Success", "OK", "Information")
} catch {
Write-Log "ERROR applying tweaks: $($_.Exception.Message)"
}
})
$BtnUndoTweaks.Add_Click({
Write-Log "Restoring default Windows settings for selected tweaks..."
if ($ChkMenuDelay.IsChecked) { Set-RegValue "HKCU:\Control Panel\Desktop" "MenuShowDelay" "400" "String" }
if ($ChkWin32Prio.IsChecked) { Set-RegValue "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" "Win32PrioritySeparation" 2 "DWord" }
if ($ChkNetThrottle.IsChecked) {
Set-RegValue "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "NetworkThrottlingIndex" 10 "DWord"
Set-RegValue "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "SystemResponsiveness" 20 "DWord"
}
if ($ChkGameBarRemove.IsChecked) {
Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" "AppCaptureEnabled" 1 "DWord"
Set-RegValue "HKCU:\System\GameConfigStore" "GameDVR_Enabled" 1 "DWord"
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -ErrorAction SilentlyContinue
}
if ($ChkMouseAccel.IsChecked) {
Set-RegValue "HKCU:\Control Panel\Mouse" "MouseSpeed" "1" "String"
Set-RegValue "HKCU:\Control Panel\Mouse" "MouseThreshold1" "6" "String"
Set-RegValue "HKCU:\Control Panel\Mouse" "MouseThreshold2" "10" "String"
}
if ($ChkHibernation.IsChecked) { powercfg.exe /hibernate on }
if ($ChkBgApps.IsChecked) { Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" "GlobalUserDisabled" 0 "DWord" }
if ($ChkWidgets.IsChecked) { Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -ErrorAction SilentlyContinue }
if ($ChkFileExt.IsChecked) { Set-RegValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 1 "DWord" }
Write-Log "SUCCESS: Selected tweaks restored to Windows defaults."
})
$ultBtns[0].Add_Click({
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
$guid = (powercfg -list | Select-String "Ultimate Performance").ToString().Split()[3]
if ($guid) { powercfg -setactive $guid; Write-Log "SUCCESS: Ultimate Performance Power Plan enabled & activated." }
})
$ultBtns[1].Add_Click({
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e
$schemes = powercfg -list | Select-String "Ultimate Performance"
foreach ($s in $schemes) { $g = $s.ToString().Split()[3]; powercfg -delete $g }
Write-Log "SUCCESS: Ultimate Performance Plan disabled & removed (Switched to Balanced)."
})
$highBtns[0].Add_Click({
powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c | Out-Null
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
Write-Log "SUCCESS: High Performance Power Plan enabled & activated."
})
$highBtns[1].Add_Click({
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e
powercfg -delete 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>$null
Write-Log "SUCCESS: High Performance Plan disabled."
})
$balBtns[0].Add_Click({
powercfg -duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e | Out-Null
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e
Write-Log "SUCCESS: Balanced Power Plan enabled & activated."
})
$balBtns[1].Add_Click({
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>$null
powercfg -delete 381b4222-f694-41f0-9685-ff5bb260df2e 2>$null
Write-Log "SUCCESS: Balanced Power Plan disabled."
})
$BtnCreateRestore.Add_Click({
Write-Log "Creating System Restore Point..."
Enable-ComputerRestore -Drive "C:" -ErrorAction SilentlyContinue
Checkpoint-Computer -Description "ProWinOptimizer_Backup" -RestorePointType "MODIFY_SETTINGS" -ErrorAction SilentlyContinue
Write-Log "SUCCESS: System Restore Point created."
})
$BtnCleanTemp.Add_Click({
Write-Log "Cleaning Windows Temp, User Temp & Prefetch folders..."
Remove-Item -Path "$env:TEMP*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Prefetch*" -Recurse -Force -ErrorAction SilentlyContinue
Write-Log "SUCCESS: Temporary junk files cleaned!"
})
$BtnRestartExplorer.Add_Click({
Write-Log "Restarting Windows Explorer..."
Stop-Process -Name explorer -Force
Write-Log "SUCCESS: Windows Explorer restarted."
})
$BtnCheckWinget.Add_Click({ Ensure-WinGet | Out-Null })
$BtnOpenPowerCpl.Add_Click({ Start-Process "powercfg.cpl" })
$win.ShowDialog() | Out-Null
