@echo off

:: Ask_Admin
net file >nul 2>nul || set _=^"set _ELEV=1^& cd /d """%cd%"""^& "%~f0" %* ^"&&((if "%_ELEV%"=="" ((powershell -nop -c start cmd -args '/d/x/s/v:off/r',$env:_ -verb runas >nul 2>nul) || (mshta vbscript:execute^("createobject(""shell.application"").shellexecute(""cmd"",""/d/x/s/v:off/r ""&createobject(""WScript.Shell"").Environment(""PROCESS"")(""_""),,""runas"",1)(window.close)"^) >nul 2>nul)))& exit /b)

Set "title=Win10_EnableCopilot"
Set "Link=https://github.com/thebookisclosed/ViVe/releases/download/v0.3.3/ViVeTool-v0.3.3.zip"

::Head
title %Title%
Mode con: Cols=95 Lines=14
echo.
Call :Logo
Call :Color 05 "   [%Title%]" &echo.

::Main
 REM Call :Color 02 "Testing internet connection" &echo.
 REM ping /n 3 8.8.8.8 >nul || (Call :Color 04 "Error Internet is not connected" &echo. && timeout /t 3 >nul && exit /b)
 Powershell Start-BitsTransfer -Source '%Link%' -Destination '%TEMP%\ViVeTool-v0.3.3.zip'
 if exist "%TEMP%\ViVeTool-v0.3.3.zip" Powershell Expand-Archive -LiteralPath '%TEMP%\ViVeTool-v0.3.3.zip' -DestinationPath 'C:\ViVeTool' -Force
 Start "" /wait C:\ViVeTool\vivetool.exe /enable /id:46686174,47530616,44755019
 REG ADD HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /V EnableCop /t REG_SZ /d "REG ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Copilot\BingChat /v IsUserEligible /t REG_DWORD /d 1 /f" /f 
 Call :Color 04 "Computer Will Restart in 10 Seconds (Close this Window to Cancel)"
 timeout /t 10
 shutdown /r /t 1 >nul
 exit /b
 
 ::=================================================================
:LOGO                                     
echo  ^@@@@@@   @@@@@@@  @@@@@@@@   @@@@@@@  
echo  ^@@@@@@@   @@@@@@@  @@@@@@@@  @@@@@@@@  
echo  ^!@@         @@!    @@!       !@@       
echo  ^!@!         !@!    !@!       !@!       
echo  ^!!@@!!      @!!    @!!!:!    !@!       
echo  ^ !!@!!!     !!!    !!!!!:    !!!       
echo  ^     !:!    !!:    !!:       :!!       
echo  ^    !:!     :!:    :!:       :!:       
echo  ^:::: ::      ::     :: ::::   ::: :::  
echo  ^:: : :       :     : :: ::    :: :: :                                       
exit /b

   ::example:call :Color 02 "WellCome"
   ::example:call :Color 02 "Well" && call :Color 03 "Come" &echo.
:Color
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a")
pushd "%temp%"
<nul set /p ".=%DEL%" > "%~2" &findstr /v /a:%1 /R "^$" "%~2" nul &del "%~2" > nul 2>&1 &popd &exit /b
