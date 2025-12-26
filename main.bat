@echo off

color A

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
	
	
echo .
echo                    **********************************************

echo               :::::::: STATE BANK OF INDIA ( UNOFFICIAL KIOSK APPLICATION SETTINGS ) ::::::::
echo .
echo                          **** KARANDIGHI ( WEST BENGAL ) ****
echo.
echo              :::::::: Developed by Binku Kumar Sinha (Pythomas) With The Help Of STACK-OVERFLOW ::::::::
echo.
echo   Disclaimer: All Trademarks and Copyrights appearing on this file ,
echo   Softwares used belongs to their respective owners.
echo.
echo 	NOTE : *** This is not Official Script File. This is made by Unofficial Person ***
echo .
echo                   __//\\_//\\_//\\_//\\_//\\_//\\_//\\_//\\__ 
echo .
rem echo 	     ******  You Do Not Need To Run As Administrator  ******
rem echo                              ( For Better Result )
echo .
echo .	

:Retry
echo.  	* This is Main Menu *
echo.	_____________________
echo.	_____________________
echo.
echo. ==Please choose your setting :
echo.		To Srvices = 1
echo.		To Main_Manu = 2
echo.		To Exit = 3

set/p "inp=>"

if %inp% GEQ 4 (
Echo Bad Command.
Echo Try again with correct choice :
goto Retry
)
if %inp%==1 goto Services
if %inp%==2 goto Main_Manu  
if %inp%==3 goto Exit 




:Services 
:One
echo.  	* This is Second Menu *
echo.	_____________________
echo.	_____________________
echo.
echo. ==Please choose your setting :
echo.		To Start = 1
echo.		To Stop = 2
echo.		To Back = 3
echo.		To Exit = 4

set/p "inp=>"

if %inp% GEQ 5 (
Echo Bad Command.
Echo Try again with correct choice :
goto One
)
if %inp%==1 goto Start
if %inp%==2 goto Stop 
if %inp%==3 goto Back
if %inp%==4 goto Exit  

:Back
goto Retry 

:Start 
net Start Idemia_L1RD_Service

net Start MSO_SpUsb_Service

net Start MORPHO_Agent_Service

net Start PinpadService

rem net Start TapiSrv

ipconfig/flushdns
pause 
goto One

:Stop 
net stop Idemia_L1RD_Service

net stop MSO_SpUsb_Service

net stop MORPHO_Agent_Service

net stop PinpadService

rem net Start TapiSrv

ipconfig/flushdns
pause 
goto One


Rem shutdown /s /f
Rem %SYSTEMROOT%\system32\shutdown.exe -s -f -t 0
:Exit
echo    Exit The PROCESS
Exit
echo "Thank You" 
goto Exit
cls




:Main_Manu
:Second
echo.	* This Third Menu *
echo.	_____________________
echo.	_____________________
echo.
echo. ==Please choose your setting :
echo.		To Open The Kiosk Portal directly in EDGE (Need to enable Pop-Up manually) = 1
echo.		To Open The Kiosk Portal directly in CHROME (Need to enable Pop-Up manually) = 2
echo.		To Open The Kiosk Portal directly in FIREFOX MOZILA (Need to enable Pop-Up manually) = 3
echo.		For Other Bank (If Aadhaar is seeded to Your Kiosk ID by Your BC Channel) = 4
echo.		To Clean The Data From All Browser = 5
echo.		For Services(If RD Service , Micro ATM or Peri Services are Not Working) = 6
echo.		To Uninstall Old Peri Service = 7
echo.		To Download RD_Service = 8
echo.		To Download Peri_Services = 9
echo.		To Download Morpho_Non_Aadhaar_Driver = 10
echo.		To Back = 11
echo.		To Exit The Programme = 12


set/p "inp=>"

if %inp% GEQ 13 (
Echo Bad Command.
Echo Try again with correct choice :
goto Second
)
if %inp%==1 goto edge
if %inp%==2 goto chrome
if %inp%==3 goto firefox
if %inp%==4 goto Other
if %inp%==5 goto Clean_All_Browser_Data
if %inp%==6 goto Service
if %inp%==7 goto Uninstall_Old_Peri
if %inp%==8 goto RD_down
if %inp%==9 goto peri_Down
if %inp%==10 goto Morpho_Aadhaar_Down
if %inp%==11 goto Back
if %inp%==12 goto Exit


:Back 
goto Retry


:RD_down
echo.
echo 		****Before Downloading The File Please Delete Old Downloaded File as Same Name.****
echo.
echo "Downloading Rd_Service For You"
powershell -command "Invoke-WebRequest https://cdn.shopify.com/s/files/1/2363/5731/files/WindowsRDServiceV2.0.1.60_HTTPs-LocalHost.zip?v=1666877080 -Outfile Rd_Service.zip" 
echo.
echo "Downloading Done"
pause
goto Second 

:Morpho_Aadhaar_Down
.
echo.
echo 		****Before Downloading The File Please Delete Old Downloaded File as Same Name.****
echo.
pause
echo "Downloading Morpho_Non_Aadhaar_Driver For You"
powershell -command "Invoke-WebRequest https://kiosk.bank.sbi/gateway/downloads/Morpho_Non_Aadhaar_Driver.zip -Outfile Morpho_Non_Aadhaar_Driver.zip" 
echo.
echo "Downloading Done"
pause
goto Second

:peri_Down
echo.
echo 		****Before Downloading The File Please Delete Old Downloaded File as Same Name.****
echo.
pause
echo "Downloading PeriService_latest For You"
powershell -command "Invoke-WebRequesthttps://cspbctools.com/software/PeriServiceSetup_V1.1.82.zip -Outfile PeriService_latest.zip" 
echo.
echo "Downloading Done"
pause
goto Second


:Service

echo .

echo              :::::::::::::::::::::::::::::::::::::::::::::::::::
echo               	      * Restarting Morpho RD Service *
echo              :::::::::::::::::::::::::::::::::::::::::::::::::::
net stop Idemia_L1RD_Service
net start Idemia_L1RD_Service
echo              :::::::::::::::::::::::::::::::::::::::::::::::::::


echo               	      * Restarting Morpho Usb Service *
echo              :::::::::::::::::::::::::::::::::::::::::::::::::::
net stop MSO_SpUsb_Service
net start MSO_SpUsb_Service
echo              :::::::::::::::::::::::::::::::::::::::::::::::::::


echo               	      * Restarting Morpho Agent RD Service *
echo              ::::::::::::::::::::::::::::::::::::::::::::::::::: 
net stop MORPHO_Agent_Service

net start MORPHO_Agent_Service
echo              :::::::::::::::::::::::::::::::::::::::::::::::::::


echo                            * Restarting Peri Service *
echo              :::::::::::::::::::::::::::::::::::::::::::::::::::

net stop PinpadService

net start PinpadService
echo              :::::::::::::::::::::::::::::::::::::::::::::::::::

REM echo		 ********** <<< FOR ALL KIND OF MICRO ATM DEVICE >>> **********

rem echo                            * Restarting Telephony Service *
rem echo                        *** FOR ALL KIND OF MICRO ATM DEVICE ***
rem echo              :::::::::::::::::::::::::::::::::::::::::::::::::::

rem net stop TapiSrv
rem net start TapiSrv
rem echo              :::::::::::::::::::::::::::::::::::::::::::::::::::

echo                                 **** DONE **** 
echo              :::::::::::::::::::::::::::::::::::::::::::::::::::
ipconfig/flushdns
rem echo "Enter Any Key to Exit The Programme ."
pause
goto Retry



:Exit
echo    Exit The PROCESS
Exit
echo "Thank You" 
pause
goto Exit
cls


:Other

del /s /f /q %windir%\temp\*.*    
rd /s /q %windir%\temp    
md %windir%\temp    
del /s /f /q %windir%\Prefetch\*.*    
rd /s /q %windir%\Prefetch    
md %windir%\Prefetch    
del /s /f /q %windir%\system32\dllcache\*.*    
rd /s /q %windir%\system32\dllcache    
md %windir%\system32\dllcache    
del /s /f /q "%SysteDrive%\Temp"\*.*    
rd /s /q "%SysteDrive%\Temp"    
md "%SysteDrive%\Temp"    
del /s /f /q %temp%\*.*    
rd /s /q %temp%    
md %temp%    
del /s /f /q "%USERPROFILE%\Local Settings\History"\*.*    
rd /s /q "%USERPROFILE%\Local Settings\History"    
md "%USERPROFILE%\Local Settings\History"    
del /s /f /q "%USERPROFILE%\Local Settings\Temporary Internet Files"\*.*    
rd /s /q "%USERPROFILE%\Local Settings\Temporary Internet Files"    
md "%USERPROFILE%\Local Settings\Temporary Internet Files"    
del /s /f /q "%USERPROFILE%\Local Settings\Temp"\*.*    
rd /s /q "%USERPROFILE%\Local Settings\Temp"    
md "%USERPROFILE%\Local Settings\Temp"    
del /s /f /q "%USERPROFILE%\Recent"\*.*    
rd /s /q "%USERPROFILE%\Recent"    
md "%USERPROFILE%\Recent"    
del /s /f /q "%USERPROFILE%\Cookies"\*.*    
rd /s /q "%USERPROFILE%\Cookies"    
md "%USERPROFILE%\Cookies"

Echo Clearing cache, cookies and history for:
rem You can delete cookies by calling InetCpl.cpl RunDll32 compatible export function ClearMyTracksByProcess
rem To delete cookies call :
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2
rem To delete history, call :
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
rem To delete everything, call :
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255
rem To delete history, cookies, and cache call:
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 43

del /f /s /q %systemdrive%\*.tmp
del /f /s /q %systemdrive%\*._mp
del /f /s /q %systemdrive%\*.log
del /f /s /q %systemdrive%\*.gid
del /f /s /q %systemdrive%\*.chk
del /f /s /q %systemdrive%\*.old
del /f /s /q %systemdrive%\recycled\*.*
del /f /s /q %windir%\*.bak
del /f /s /q %windir%\prefetch\*.*
rd /s /q %windir%\temp & md %windir%\temp
del /f /q %userprofile%\cookies\*.*
del /f /q %userprofile%\recent\*.*
del /f /s /q “%userprofile%\Local Settings\Temporary Internet Files\*.*”
del /f /s /q “%userprofile%\Local Settings\Temp\*.*”
del /f /s /q “%userprofile%\recent\*.*”


cleanmgr

@rem Clear Edge cache
taskkill /IM msedge.exe /F
erase "%LOCALAPPDATA%\Microsoft\Edge\User Data\*.*" /f /s /q
for /D %%i in ("%LOCALAPPDATA%\Microsoft\Edge\User Data\*") do RD /S /Q "%%i"


@rem Clear Google Chrome cache
taskkill /IM chrome.exe /F
erase "%LOCALAPPDATA%\Google\Chrome\User Data\*.*" /f /s /q
for /D %%i in ("%LOCALAPPDATA%\Google\Chrome\User Data\*") do RD /S /Q "%%i"
:: Purge the cache, cookies, and history
pushd "%LOCALAPPDATA%\Google\Chrome\User Data\Default"
del /f /s /q ".\Cache\*.*" ".\*Cookies*.*" ".\*History*.*"
cd "%USERPROFILE%\Local Settings\Application Data\Google\Chrome\User Data\Default"
del /f /s /q ".\Cache\*.*" ".\*Cookies*.*" ".\*History*.*"
popd
ipconfig/flushdns

rem start chrome.exe https://kiosk.sbi.bank.in/ -incognito
rem start chrome.exe https://kiosk.sbi.bank.in/

rem echo ===============================================================
rem echo .
rem echo    ** You Need To Clear Browsing History, Download History, Cookies, Cache and Autofill From Data Manually **
rem echo .
rem echo 				"Enter Any Key to Exit The Programme ."
pause
goto Second


:Uninstall_Old_Peri

echo .................Uninstalling OLD PeriServices.................
echo .
WMIC Product where "Name='PeriServiceSetup'" Call Uninstall /NoInteractive

echo " Unistall Done , Now Download The Latest Version Of Peri Service From The SBI KIOSK Portal and Install manually ."
pause
goto Second




:edge

REM Stop Microsoft Edge if it's running
taskkill /IM msedge.exe /F >nul 2>&1

REM Clear Edge history, autofill data, download history, and cache
del /q /f "%LocalAppData%\Microsoft\Edge\User Data\Default\History" >nul 2>&1
del /q /f "%LocalAppData%\Microsoft\Edge\User Data\Default\History-journal" >nul 2>&1
del /q /f "%LocalAppData%\Microsoft\Edge\User Data\Default\History Provider Cache" >nul 2>&1
del /q /f "%LocalAppData%\Microsoft\Edge\User Data\Default\Cookies" >nul 2>&1
del /q /f "%LocalAppData%\Microsoft\Edge\User Data\Default\Cookies-journal" >nul 2>&1
del /q /f "%LocalAppData%\Microsoft\Edge\User Data\Default\Autofill" >nul 2>&1
del /q /f "%LocalAppData%\Microsoft\Edge\User Data\Default\Downloads" >nul 2>&1
del /q /f "%LocalAppData%\Microsoft\Edge\User Data\Default\Top Sites" >nul 2>&1
del /q /f "%LocalAppData%\Microsoft\Edge\User Data\Default\Visited Links" >nul 2>&1
rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache" >nul 2>&1

echo Microsoft Edge history, autofill data, download history, and cache have been cleared.

taskkill /IM msedge.exe /F
ipconfig/flushdns
start microsoft-edge:https://kiosk.sbi.bank.in/
goto exit



:chrome
taskkill /F /IM chrome.exe > nul

REM Clear Chrome history, autofill data, download history, and cache
del /q /f "%LocalAppData%\Google\Chrome\User Data\Default\History" >nul 2>&1
del /q /f "%LocalAppData%\Google\Chrome\User Data\Default\History Provider Cache" >nul 2>&1
del /q /f "%LocalAppData%\Google\Chrome\User Data\Default\History-journal" >nul 2>&1
del /q /f "%LocalAppData%\Google\Chrome\User Data\Default\Archived History" >nul 2>&1
del /q /f "%LocalAppData%\Google\Chrome\User Data\Default\Login Data" >nul 2>&1
del /q /f "%LocalAppData%\Google\Chrome\User Data\Default\Cookies" >nul 2>&1
del /q /f "%LocalAppData%\Google\Chrome\User Data\Default\Web Data" >nul 2>&1
del /q /f "%LocalAppData%\Google\Chrome\User Data\Default\Last Session" >nul 2>&1
del /q /f "%LocalAppData%\Google\Chrome\User Data\Default\Last Tabs" >nul 2>&1
del /q /f "%LocalAppData%\Google\Chrome\User Data\Default\Current Session" >nul 2>&1
del /q /f "%LocalAppData%\Google\Chrome\User Data\Default\Current Tabs" >nul 2>&1
del /q /f "%LocalAppData%\Google\Chrome\User Data\Default\TransportSecurity" >nul 2>&1
rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache" >nul 2>&1
rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\GPUCache" >nul 2>&1


echo Google Chrome history and autofill data cleared.
taskkill /F /IM chrome.exe > nul
rem start chrome.exe https://kiosk.sbi.bank.in/ -incognito
ipconfig/flushdns
start chrome.exe https://kiosk.sbi.bank.in/
goto exit



:firefox

REM Stop Mozilla Firefox if it's running
taskkill /IM firefox.exe /F >nul 2>&1

REM Clear Firefox history, autofill data, download history, and cache
del /q /f "%AppData%\Mozilla\Firefox\Profiles\*\places.sqlite" >nul 2>&1
del /q /f "%AppData%\Mozilla\Firefox\Profiles\*\formhistory.sqlite" >nul 2>&1
del /q /f "%AppData%\Mozilla\Firefox\Profiles\*\downloads.sqlite" >nul 2>&1
del /q /f "%AppData%\Mozilla\Firefox\Profiles\*\cache2\*" >nul 2>&1

echo Mozilla Firefox history, autofill data, download history, and cache have been cleared.

taskkill /IM firefox.exe /F
ipconfig/flushdns
start firefox.exe https://kiosk.sbi.bank.in/
goto exit


:Clean_All_Browser_Data
erase "%TEMP%\*.*" /f /s /q

for /D %%i in ("%TEMP%\*") do RD /S /Q "%%i"

erase "%TMP%\*.*" /f /s /q

for /D %%i in ("%TMP%\*") do RD /S /Q "%%i"

erase "%ALLUSERSPROFILE%\TEMP\*.*" /f /s /q

for /D %%i in ("%ALLUSERSPROFILE%\TEMP\*") do RD /S /Q "%%i"

erase "%SystemRoot%\TEMP\*.*" /f /s /q

for /D %%i in ("%SystemRoot%\TEMP\*") do RD /S /Q "%%i"

@rem Clear IE cache - (Deletes Temporary Internet Files Only)

RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8

erase "%LOCALAPPDATA%\Microsoft\Windows\Tempor~1\*.*" /f /s /q

for /D %%i in ("%LOCALAPPDATA%\Microsoft\Windows\Tempor~1\*") do RD /S /Q "%%i"

@rem Clear Edge cache

erase "%LOCALAPPDATA%\Microsoft\Edge\User Data\*.*" /f /s /q

for /D %%i in ("%LOCALAPPDATA%\Microsoft\Edge\User Data\*") do RD /S /Q "%%i"

@rem Clear Google Chrome cache

erase "%LOCALAPPDATA%\Google\Chrome\User Data\*.*" /f /s /q

for /D %%i in ("%LOCALAPPDATA%\Google\Chrome\User Data\*") do RD /S /Q "%%i"a

@rem Clear Firefox cache

erase "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*.*" /f /s /q

for /D %%i in ("%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*") do RD /S /Q "%%i"
echo .
echo .
echo Clearing Done , Now choose any Browser with Number to Work with SBI KIOSK Portal .
pause 
goto Second
cls

:Exit
:Exit
echo    Exit The PROCESS
Exit
echo "Thank You" 
goto Exit
cls
