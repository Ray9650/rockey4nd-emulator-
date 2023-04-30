@ECHO OFF

ECHO BCDEdit.exe TESTSIGNING automation script
ECHO.
ECHO.
ECHO This batch script set requirements for success install
ECHO unsigned drivers (like dongle emulators) on Microsoft x64 OS.
ECHO Required for Windows Vista x64, Windows 7 x64, Windows 8 x64
ECHO and Windows 10 x64.
ECHO.
ECHO YOU MUST RUN THIS SCRIPT AS ADMINISTRATOR
ECHO.
ECHO USAGE: Right click on script "Run as administrator"
ECHO.
ECHO Press any key to continue execution or Ctrl+C to stop
ECHO.
pause

set BCDCL32=%windir%\Sysnative\bcdedit.exe
set BCDCL64=%windir%\system32\bcdedit.exe

cd /d "%~dp0"

if "%PROCESSOR_ARCHITEW6432%"=="" goto fNative
set PROCSTRX=32-bit process
set BCDCLWORK=%BCDCL32%
goto fMain

:fNative
set PROCSTRX=64-bit process
set BCDCLWORK=%BCDCL64%

:fMain
ECHO.
ECHO %PROCSTRX%
ECHO BCDEdit.exe path is %BCDCLWORK%
if not exist %BCDCLWORK% goto NotFound

ECHO.
ECHO Change testsigning settings...

REM Show Boot Configuration Data (BCD) info...
%BCDCLWORK%

REM This enable testsigning...
REM %BCDCLWORK% -set TESTSIGNING ON

REM This disable testsigning...
REM %BCDCLWORK% -set TESTSIGNING OFF

goto aExit

:NotFound
ECHO.
ECHO BCDEdit.exe not found on system. Nothing to do!!!
goto fExit

:aExit
ECHO.
REM ECHO Please restart computer to apply new settings!!!

:fExit
ECHO.
pause
