@echo off
setlocal enabledelayedexpansion

:: Check flags
if "%~1" == "-S"   goto DOWNLOAD_DIRECT
if "%~1" == "-Sy"  goto LIST_INSTALLED
if "%~1" == "-Syu" goto CHECK_UPDATES
if "%~1" == "-R"   goto REMOVE_PACKAGE
if "%~1" == "help" goto USAGE

echo Unknown flag "%~1", please enter flag "help" for more information.
exit /b

:USAGE
echo Usage:
echo   pacgit -S [author] [repo name] - Install directly from GitHub Repository
echo   pacgit -Sy                     - List all installed packages
echo   pacgit -Syu                    - Check for available updates
echo   pacgit -R [package name]       - Remove an installed package
echo   pacgit help                    - Show this is menu
exit /b


:: ==========================================
:: LOGIC -Sy (List Installed Packages)
:: ==========================================
:LIST_INSTALLED
echo [pacgit] Installed packages:
echo ----------------------------------------------------
set "found_any=0"

for /d %%D in ("%userprofile%\git-packages\*") do (
    set "found_any=1"
    set "p_name="
    set "p_ver="
    set "p_auth="
    
    if exist "%%D\info.txt" (
        for /f "tokens=1,* delims=: " %%A in ('type "%%D\info.txt"') do (
            if /i "%%A" == "Name"    set "p_name=%%B"
            if /i "%%A" == "Version" set "p_ver=%%B"
            if /i "%%A" == "Author"  set "p_auth=%%B"
        )
    )
    if "!p_name!" == "" set "p_name=%%~nD"
    if "!p_ver!" == ""  set "p_ver=unknown"
    if "!p_auth!" == "" set "p_auth=unknown"
    
    echo  !p_name! [v!p_ver!] by !p_auth!
)
if "!found_any!" == "0" echo [pacgit] No packages found.
echo ----------------------------------------------------
pause
exit /b


:: ==========================================
:: LOGIC -Syu (Check Updates via pacgit.bat)
:: ==========================================
:CHECK_UPDATES
echo [pacgit] Checking updates for installed packages...
echo ----------------------------------------------------
set "temp_chk=%TEMP%\pacgit_chk_ver.bat"

for /d %%D in ("%userprofile%\git-packages\*") do (
    set "p_name="
    set "p_ver="
    set "p_auth="
    
    if exist "%%D\info.txt" (
        for /f "tokens=1,* delims=: " %%A in ('type "%%D\info.txt"') do (
            if /i "%%A" == "Name" set "p_name=%%B"
            if /i "%%A" == "Version" set "p_ver=%%B"
            if /i "%%A" == "Author"  set "p_auth=%%B"
        )
    )

if not "!p_name!" == "" (
    if not "!p_auth!" == "" (
        if not "!p_ver!" == "" (
            if exist "%temp_chk%" del "%temp_chk%"
            
            :: Download the author's remote pacgit.bat to check the version.
            curl -f -s -L "https://raw.githubusercontent.com/!p_auth!/!p_name!/main/pacgit.bat" -o "%temp_chk%"
            
            if exist "%temp_chk%" (
                set "remote_ver="
                :: Ищем строчку с версией внутри скачанного батника автора
                for /f "tokens=1,2,3 delims=: " %%X in ('type "%temp_chk%"') do (
                    if /i "%%Y" == "Version" set "remote_ver=%%Z"
                )
                del "%temp_chk%"
                
                if not "!remote_ver!" == "" (
                    if not "!p_ver!" == "!remote_ver!" (
                        echo  [!] Package !p_name!: New update available ^(!p_ver! -^> !remote_ver!^). Run: pacgit -S !p_auth! !p_name!
                    ) else (
                        echo  [^] Package !p_name!: Up to date ^(!p_ver!^)
                    )
                ) else (
                    echo  [?] Package !p_name!: Remote version tag not found in pacgit.bat.
                )
            ) else (
                echo  [X] Package !p_name!: Project not found or unreachable.
            )
        )
    )
)
)
echo ----------------------------------------------------
pause
exit /b


:: ==========================================
:: LOGIC -R (Remove Package)
:: ==========================================
:REMOVE_PACKAGE
if "%~2" == "" (
    echo [pacgit] Error: Package name not specified.
    pause
    exit /b
)
set "target_pkg=%~2"
set "pkg_dir=%userprofile%\git-packages\%target_pkg%"

if not exist "%pkg_dir%" (
    echo [pacgit] Error: Package "%target_pkg%" is not installed.
    pause
    exit /b
)

echo [pacgit] Running uninstall script for %target_pkg%...
echo ----------------------------------------------------
if exist "%pkg_dir%\uninstall.bat" (
    call "%pkg_dir%\uninstall.bat"
) else (
    echo [pacgit] Warning: No uninstall.bat found for this package.
)
echo ----------------------------------------------------
echo [pacgit] Cleaning up package files...
rmdir /s /q "%pkg_dir%"
echo [pacgit] Package "%target_pkg%" successfully removed.
pause
exit /b


:: ==========================================
:: LOGIC -S (Direct Download)
:: ==========================================
:DOWNLOAD_DIRECT
if "%~2" == "" goto USAGE
if "%~3" == "" goto USAGE
set "pkg_author=%~2"
set "pkg_name=%~3"
set "target_pkg=%~3"
goto RUN_INSTALLER_LOGIC

:: ==========================================
:: CORE INSTALLATION BLOCK
:: ==========================================
:RUN_INSTALLER_LOGIC
cls
echo [pacgit] Fetching pacgit.bat from %pkg_author%/%pkg_name%...
set "temp_installer=%TEMP%\pacgit_install_%pkg_name%.bat"

:: Download only pacgit.bat directly from the author's repository.
curl -f -s -L "https://raw.githubusercontent.com/%pkg_author%/%pkg_name%/main/pacgit.bat" -o "%temp_installer%"

if %errorlevel% NEQ 0 (
    echo [pacgit] Error: Project not found.
    if exist "%temp_installer%" del "%temp_installer%"
    pause
    exit /b
)

:: Define a path variable for a specific project
set "git-package-default=%userprofile%\git-packages\%target_pkg%"

:: We look for the version directly in the author's downloaded batch file before installation
set "extracted_ver=1.0"
for /f "tokens=2 delims=: " %%X in ('type "%temp_installer%" ^| findstr /I "Version:"') do (
    set "extracted_ver=%%X"
)

echo [pacgit] Starting installation for "%target_pkg%" [v%extracted_ver%]...
echo ----------------------------------------------------
echo.

:: Run the author's script and pass it the path to its future folder.
call "%temp_installer%" "%git-package-default%"

echo.
echo ----------------------------------------------------

:: Create info.txt ONLY if the author did not create it during installation.
if not exist "%git-package-default%\info.txt" (
    if exist "%git-package-default%" (
        echo Name: %pkg_name% > "%git-package-default%\info.txt"
        echo Version: %extracted_ver% >> "%git-package-default%\info.txt"
        echo Author: %pkg_author% >> "%git-package-default%\info.txt"
    )
)

echo [pacgit] Installation of %target_pkg% finished!
if exist "%temp_installer%" del "%temp_installer%"
pause
exit /b
