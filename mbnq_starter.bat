@echo off
title CA Starter ^(mbnq.pl^)
SETLOCAL DISABLEDELAYEDEXPANSION
cls

:: Runs first instance on all resources while running
:: other instances minimised on 1 core to save resources

:: ---------- config ----------

:: put your game path here between ""
set _gamePath="G:\Custom-Archlord (2)\Custom-Archlord\"

:: Do you want to run update before launching? TRUE or FALSE
set _runUpdate=FALSE

:: How many clients do you want to be started? 
set /a _runIT=5

:: ------ end of config -------


:: do not edit bellow!
set /a _counter=0
set /a _pauseTime=5
cd /d %_gamePath%

if not exist AlefClient.exe goto ERROR0
if not exist AlefLauncher.exe goto ERROR0
if %_runIT% LSS 1 goto ERROR1
if %_runIT% GTR 16 goto ERROR1

echo:Config loaded!
echo:You may need to start this as administrator^.
if NOT %_runUpdate%==TRUE goto bypassUpdate
echo:Updating...
echo:Wait 15s or press any key to stop updating...
start AlefLauncher.exe
timeout /t 15 > nul
taskkill /F /IM "javaw.exe" > nul

:bypassUpdate

:mainLoop
set /a _counter=%_counter%+1
echo:Starting instance^:%_counter%
if %_counter% EQU 1 (start "Primary" AlefClient.exe) else (start /LOW /MIN /AFFINITY 4 AlefClient.exe)
if %_counter% GEQ %_runIT% goto END
timeout /T %_pauseTime% > nul
goto mainLoop

goto END

:ERROR0
echo:Game files not found! 
echo:Make sure game path config it's setup correctly!
goto END

:ERROR1
echo:Cannot run %_runIT% instances! 
echo:Make sure config it's setup correctly!
goto END

:END
echo:Press any key to quit...
pause > nul