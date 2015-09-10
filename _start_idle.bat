@echo off
setlocal enableextensions
title Ilde Steam cards [v0.50] console by Giza(tr1ton)
color 80
chcp 65001> nul
pushd "%~dp0"

:Tools
set "IdleCfg=%~dpn0.ini"
set "SfkTool=%~dp0Resources\Tools\Sfk.exe"
set "nodetool=node"

:Shortcuts
set "Date=%date%"
set "EchoD="%SfkTool%" echo"
set "EchoS="%SfkTool%" echo -spat"
set "Wait=ping>nul "127.0.0.1" -n"
set "Pause="%SfkTool%" pause"

:ProcessIniFile
for /f "usebackq eol=# tokens=1,* delims==	 " %%m in ("%IdleCfg%") do (
	if not "%%~n"=="" (call set "%%~m=%%~n")
)

:ActionMenu
cls
%EchoS% "  Ilde Steam cards [v0.30] console by Giza(tr1ton)[def]."
%EchoD% "[green]	Select the account to Idle:"
echo.
if exist "%acc_1%\*.js" (%EchoD% "    [blue]1. [def]%acc_1%;")
if exist "%acc_2%\*.js" (%EchoD% "    [blue]2. [def]%acc_2%;")
if exist "%acc_3%\*.js" (%EchoD% "    [blue]3. [def]%acc_3%;")
if exist "%acc_4%\*.js" (%EchoD% "    [blue]4. [def]%acc_4%;")
if exist "%acc_5%\*.js" (%EchoD% "    [blue]5. [def]%acc_5%;")
if exist "%acc_6%\*.js" (%EchoD% "    [blue]6. [def]%acc_6%;")
if exist "%acc_7%\*.js" (%EchoD% "    [blue]7. [def]%acc_7%;")
if exist "%acc_8%\*.js" (%EchoD% "    [blue]8. [def]%acc_8%;")
if exist "%acc_9%\*.js" (%EchoD% "    [blue]9. [def]%acc_9%;")
if exist "%acc_10%\*.js" (%EchoD% "    [blue]10. [def]%acc_10%;")
if exist "%acc_11%\*.js" (%EchoD% "    [blue]11. [def]%acc_11%;")
if exist "%acc_12%\*.js" (%EchoD% "    [blue]12. [def]%acc_12%;")
if exist "%acc_13%\*.js" (%EchoD% "    [blue]13. [def]%acc_13%;")
if exist "%acc_14%\*.js" (%EchoD% "    [blue]14. [def]%acc_14%;")
if exist "%acc_15%\*.js" (%EchoD% "    [blue]15. [def]%acc_15%;")
if exist "%acc_16%\*.js" (%EchoD% "    [blue]16. [def]%acc_16%;")
if exist "%acc_17%\*.js" (%EchoD% "    [blue]17. [def]%acc_17%;")
%EchoD% "    [blue]99. [def]Another account;"
echo.
%EchoD% "    [blue]Q.  [def]Quit the program."
echo.

set "Action="
set /p "Action=> "
cls


if /i "%Action%"=="1" (
set acc=%acc_1%
goto idletime
)
if /i "%Action%"=="2" (
set acc=%acc_2%
goto idletime
)
if /i "%Action%"=="3" (
set acc=%acc_3%
goto idletime
)

if /i "%Action%"=="4" (
set acc=%acc_4%
goto idletime
)
if /i "%Action%"=="5" (
set acc=%acc_5%
goto idletime
)
if /i "%Action%"=="6" (
set acc=%acc_6%
goto idletime
)
if /i "%Action%"=="7" (
set acc=%acc_7%
goto idletime
)
if /i "%Action%"=="8" (
set acc=%acc_8%
goto idletime
)
if /i "%Action%"=="9" (
set acc=%acc_9%
goto idletime
)
if /i "%Action%"=="10" (
set acc=%acc_10%
goto idletime
)
if /i "%Action%"=="11" (
set acc=%acc_11%
goto idletime
)
if /i "%Action%"=="12" (
set acc=%acc_12%
goto idletime
)
if /i "%Action%"=="13" (
set acc=%acc_13%
goto idletime
)
if /i "%Action%"=="14" (
set acc=%acc_14%
goto idletime
)
if /i "%Action%"=="15" (
set acc=%acc_15%
goto idletime
)
if /i "%Action%"=="16" (
set acc=%acc_16%
goto idletime
)
if /i "%Action%"=="17" (
set acc=%acc_17%
goto idletime
)

if /i "%Action%"=="99" (goto UserAccount)

if /i "%Action%"=="Q"  (goto Quitidle)

goto ActionMenu

:idletime
echo.
%EchoD% "[green]	Select the method Idle:"
echo.
%EchoD% "    [blue]1. Standart;"
%EchoD% "    [blue]2. Start all game 2 hours;"
%EchoD% "    [blue]3. Manual all game hours;"
echo.

set "Action1="
set /p "Action1=> "
cls

if /i "%Action1%"=="1" (goto idletime_one_game)
if /i "%Action1%"=="2" (goto idletime_all_game_2h)
if /i "%Action1%"=="3" (goto usercfgtime)

goto idletime

:usercfgtime
echo.
%EchoD% "[green]	Enter the time(min):"
echo.

set "Action_time="
set /p "Action_time=> "
cls

if /i "%Action_time%"=="%Action_time%" (goto usercfgtime2)

goto usercfgtime

:usercfgtime2
::if /i %Action_time% LEQ 1 (goto usercfgtime)
if /i "%Action_time%"=="" (goto usercfgtime)

set verfile=%acc%\%jsscript_manual%
set tmpfile=%acc%\%jsscript_manual%.tmp
set "seek=	var preTimer"
if exist %tmpfile% del /q %tmpfile%
for /f "delims=" %%a in (%verfile%) do (
  (echo %%a)|>nul find /i "%seek% = "&&((echo %seek% = %Action_time%*60*1000;)>>%tmpfile%)
  (echo %%a)|>nul find /i "%seek% = "||(echo %%a)>>%tmpfile%
  cls
)
copy /y %tmpfile% %verfile% >nul
del /f /q %tmpfile% >nul

goto idletime_all_game_manual


:UserAccount

echo.
%EchoD% "[green]Enter Account Login:"

set "acc="
set /p "acc=> "

if /i "%acc%"=="" (goto UserAccount)
if /i "%acc%"=="Q" (goto ActionMenu)

if exist %acc%\%jsscript% (
  echo This directory contains files idle
%EchoD% "[green]Start Idle %acc%?(y/n)"
) else (goto UserAccountP)

set "Action_ua_start="
set /p "Action_ua_start=> "
	
if /i "%Action_ua_start%"=="Y" (goto idletime)
if /i "%Action_ua_start%"=="N" (goto ActionMenu)
  
:UserAccountP
echo.
%EchoD% "[green]Enter Account Password:"

set "Action_ua_p="
set /p "Action_ua_p=> "

if /i "%Action_ua_p%"=="Q" (goto ActionMenu)

if /i "%Action_ua_p%"=="" (goto UserAccountP)

md %acc%
xcopy "%jsscript%" "%acc%\"
xcopy "%jsscript2h%" "%acc%\"
xcopy "%jsscript_manual%" "%acc%\"
::For %%I In (%IdleCfg%) Do Echo acc_18	=	%acc%>>"%%I"
cls

set verfile=%acc%\%jsscript%
set tmpfile=%acc%\%jsscript%.tmp

:filesedits
set "log_pasw=%acc%"
set "seek=var username1"

call :fileeditname

set "log_pasw=%Action_ua_p%"
set "seek=var password1"

call :fileeditname

if /i "%fileedit_2h%"=="1" (goto filesedits2)
if /i "%fileedit_2h%"=="2" (goto idletime)

set verfile=%acc%\%jsscript2h%
set tmpfile=%acc%\%jsscript2h%.tmp

set "fileedit_2h=1"
goto filesedits

:filesedits2
set verfile=%acc%\%jsscript_manual%
set tmpfile=%acc%\%jsscript_manual%.tmp

set "fileedit_2h=2"
goto filesedits

:fileeditname
if exist %tmpfile% del /q %tmpfile%
for /f "delims=" %%a in (%verfile%) do (
  (echo %%a)|>nul find /i "%seek% = "&&((echo %seek% = '%log_pasw%';)>>%tmpfile%)
  (echo %%a)|>nul find /i "%seek% = "||(echo %%a)>>%tmpfile%
   cls
)
copy /y %tmpfile% %verfile% >nul
del /f /q %tmpfile% >nul
exit /b

:idletime_one_game
start %nodetool% %acc%\%jsscript%
goto ActionMenu


:idletime_all_game_2h
start %nodetool% %acc%\%jsscript2h%
goto ActionMenu

:idletime_all_game_manual
start %nodetool% %acc%\%jsscript_manual%
goto ActionMenu

:Quitidle
	color
	popd
	popd
	endlocal
exit /b 0
