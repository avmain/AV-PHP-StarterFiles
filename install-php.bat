@echo off

:CheckOS
IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)

:64BIT
echo 64-bit Architecture Found
echo Downloading PHP for x64
timeout 2
bitsadmin.exe /transfer "PHP Download" http://windows.php.net/downloads/releases/php-5.6.32-Win32-VC11-x64.zip C:\php.zip
echo Download Completed.
echo Extracting Files.
powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('C:\php.zip', 'C:\php'); }
echo Setting Path Variables.
SET PHP="C:\php"
setx PATH "%PHP%"
echo PHP has been installed.

echo Configuring Settings
timeout 2
powershell -Command "(gc C:\php\php.ini-production) -replace ';extension=php_openssl.dll', 'extension=php_openssl.dll' | Out-File -encoding ASCII C:\php\php.ini-production"
powershell -Command "(gc C:\php\php.ini-production) -replace ';extension=php_mysqli.dll', 'extension=php_mysqli.dll' | Out-File -encoding ASCII C:\php\php.ini"

echo Installation Finished. Exiting.
timeout 10

GOTO END

:32BIT
echo 64-bit Architecture Found
echo Downloading PHP for x64
pause 2
bitsadmin.exe /transfer "PHP Download" http://windows.php.net/downloads/releases/php-5.6.32-Win32-VC11-x86.zip C:\php.zip
echo Download Completed.
echo Extracting Files.
powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('C:\php.zip', 'C:\php'); }
echo Setting Path Variables.
SET PHP="C:\php"
setx PATH "%PHP%"
echo PHP has been installed.

echo Configuring Settings
timeout 2
powershell -Command "(gc C:\php\php.ini-production) -replace ';extension=php_openssl.dll', 'extension=php_openssl.dll' | Out-File -encoding ASCII C:\php\php.ini-production"
powershell -Command "(gc C:\php\php.ini-production) -replace ';extension=php_mysqli.dll', 'extension=php_mysqli.dll' | Out-File -encoding ASCII C:\php\php.ini"

echo Installation Finished. Exiting.
timeout 10
GOTO END

:END