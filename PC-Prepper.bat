@echo off
setlocal enabledelayedexpansion

:: Check if the script is running with administrator privileges
NET SESSION >nul 2>&1
if %errorLevel%==0 (
    echo Running with administrator privileges...
) else (
    echo Restarting as administrator...
    powershell -Command "Start-Process -Verb RunAs -FilePath '%0' -ArgumentList @()"
    exit /b
)

:: Set Chrome as the default browser
echo Setting Google Chrome as the default browser...
start chrome --make-default-browser

:: Set Windows to dark mode
echo Enabling Dark Mode...
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d 0 /f

:: Set the download URLs for the programs
set "ChromeURL=https://dl.google.com/chrome/install/GoogleChromeStandaloneEnterprise64.msi"
set "PythonURL=https://www.python.org/ftp/python/3.9.7/python-3.9.7-amd64.exe"
set "VLCURL=https://get.videolan.org/vlc/3.0.16/win64/vlc-3.0.16-win64.exe"
set "DiscordURL=https://discord.com/api/download?platform=win"
set "SteamURL=https://steamcdn-a.akamaihd.net/client/installer/SteamSetup.exe"
set "ShutterEncoderURL=https://www.shutterencoder.com/shutter_encoder_windows.zip"
set "SevenZipURL=https://www.7-zip.org/a/7z2100-x64.exe"
set "JavaURL=https://javadl.oracle.com/webapps/download/GetFile/1.8.0_312-b07/de572d45f65b463fb3b0a5ce5a2d5247/windows-i586/jre-8u312-windows-i586.exe"
set "PaintNetURL=https://paintnet.bintray.com/releases/4.3.6/Paint.NET.4.3.6.Install.exe"

:: Set the installation paths for the programs
set "ChromeInstallPath=%ProgramFiles%\Google\Chrome"
set "PythonInstallPath=%ProgramFiles%\Python39"
set "VLCInstallPath=%ProgramFiles%\VideoLAN\VLC"
set "DiscordInstallPath=%AppData%\Discord"
set "SteamInstallPath=%ProgramFiles%\Steam"
set "ShutterEncoderInstallPath=%ProgramFiles%\ShutterEncoder"
set "SevenZipInstallPath=%ProgramFiles%\7-Zip"
set "JavaInstallPath=%ProgramFiles%\Java"
set "PaintNetInstallPath=%ProgramFiles%\paint.net"

:: Function to display a progress bar
:ProgressBar
setlocal enabledelayedexpansion
set "progress="
for /l %%i in (1,1,%1) do (
    set "progress=!progress=#"
    echo|set /p=!progress! !2!%% complete^^^>^^^>^^^>^^^>^^^>^^^>
    timeout /t 1 /nobreak >nul
)
endlocal
goto :eof

:: Download and install Google Chrome silently with a progress bar
echo Installing Google Chrome...
curl -o "ChromeInstaller.msi" "%ChromeURL%"
start /wait msiexec /i "ChromeInstaller.msi" /qn /norestart
del "ChromeInstaller.msi"
call :ProgressBar 20 "Google Chrome"

:: Download and install Python silently with a progress bar
echo Installing Python...
curl -o "PythonInstaller.exe" "%PythonURL%"
start /wait "Python Installer" "PythonInstaller.exe" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
del "PythonInstaller.exe"
call :ProgressBar 20 "Python"

:: Download and install VLC Player silently with a progress bar
echo Installing VLC Player...
curl -o "VLCInstaller.exe" "%VLCURL%"
start /wait "VLC Player Installer" "VLCInstaller.exe" /S
del "VLCInstaller.exe"
call :ProgressBar 20 "VLC Player"

:: Download and install Discord silently with a progress bar
echo Installing Discord...
curl -o "DiscordInstaller.exe" "%DiscordURL%"
start /wait "Discord Installer" "DiscordInstaller.exe" /S
del "DiscordInstaller.exe"
call :ProgressBar 20 "Discord"

:: Download and install Steam silently with a progress bar
echo Installing Steam...
curl -o "SteamSetup.exe" "%SteamURL%"
start /wait "Steam Installer" "SteamSetup.exe" /S
del "SteamSetup.exe"
call :ProgressBar 20 "Steam"

:: Download and install Shutter Encoder with a progress bar
echo Installing Shutter Encoder...
curl -o "ShutterEncoder.zip" "%ShutterEncoderURL%"
powershell -command "Expand-Archive -Path .\ShutterEncoder.zip -DestinationPath \"%ShutterEncoderInstallPath%\""
del "ShutterEncoder.zip"
call :ProgressBar 20 "Shutter Encoder"

:: Download and install 7-Zip silently with a progress bar
echo Installing 7-Zip...
curl -o "7zInstaller.exe" "%SevenZipURL%"
start /wait "7-Zip Installer" "7zInstaller.exe" /S
del "7zInstaller.exe"
call :ProgressBar 20 "7-Zip"

:: Download and install Java silently with a progress bar
echo Installing Java...
curl -o "JavaInstaller.exe" "%JavaURL%"
start /wait "Java Installer" "JavaInstaller.exe" /s
del "JavaInstaller.exe"
call :ProgressBar 20 "Java"

:: Download and install Paint.NET silently with a progress bar
echo Installing Paint.NET...
curl -o "PaintNetInstaller.exe" "%PaintNetURL%"
start /wait "Paint.NET Installer" "PaintNetInstaller.exe" /S
del "PaintNetInstaller.exe"
call :ProgressBar 20 "Paint.NET"

echo All programs have been installed successfully.
pause
