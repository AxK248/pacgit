:: Version: 1.0
:: pacwin installer for windows
:: Start a installer
@echo off
setlocal enabledelayedexpansion

echo %userprofile%^> pacwin -S axk248 pacgit

set "old_path="
for /f "tokens=2*" %%a in ('reg query "HKCU\Environment" /v PATH 2^>nul') do set "old_path=%%b"

echo !old_path! | findstr /i /c:".github-packages\pacgit" >nul

if %errorlevel% neq 0 (
    reg add "HKCU\Environment" /v PATH /t REG_EXPAND_SZ /d "!old_path!;.^%git-package^%;^%git-package^%\pacgit" /f >nul
)

reg add "HKCU\Environment" /v git-package /t REG_EXPAND_SZ /d "%%USERPROFILE%%\.github-packages" /f >nul
reg add "HKCU\Environment" /v pacgit /t REG_EXPAND_SZ /d "%%git-package%%\pacgit" /f >nul

mkdir "%userprofile\.github-packages%" 2>nul
rd /s /q "%userprofile%\.github-packages\pacgit" 2>nul
mkdir "%userprofile%\.github-packages\pacgit" 2>nul

curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/main/pacgit-dat.bat" -o "%userprofile%\.github_packages\pacgit\pacgit.bat"
curl -sL "https://raw.githubusercontent.com/AxK248/pacgit/main/info.txt" -o "%userprofile%\.github_packages\pacgit\info.txt"

echo %%git-package%%\pacgit^> echo Install complate
echo Install complate
timeout /t -1
exit /b
