:: mass decrypt script by mbnq.pl
:: mbnq@mbnq.pl mbnq00@gmail.com
::
:: Place me in directory with files to rescrypt


title Mass File RESCRYPT by mbnq.pl 
@echo off
color 17
setlocal enabledelayedexpansion

:: variables
set backup=true
set /a _allfiles=0
set _extensions=*.ini *.txt
set _decryptor=rescryptINI.exe
set autoname=backup_%date%_%random%

:: checks
for %%x in (%_extensions%) do (set /a _allfiles = _allfiles + 1)
if not exist %_decryptor% GOTO 0xe00000
if %_allfiles% LSS 1 GOTO 0xe00001
cls

:: main
call :intro
echo:Found %_allfiles% files ^^!
if %backup%==true (
	echo:Making backup, please wait...
	if not exist BACKUP (md BACKUP)
	MD BACKUP\%autoname%
	for %%x in (%_extensions%) do (copy "%%x" BACKUP\%autoname%\"%%x" > nul)
)
echo:Proceeding
echo:Rescrypting and replacing files:
echo:
for %%x in (%_extensions%) do (%_decryptor% "%%x" > nul & DEL /F /Q "%%x" & REN "%%x_" "%%x" & echo: ^> ^%%x - ok^^!)
echo:
echo:Done ^^!
call :hold

:: fnc
goto end

:0xe00000
   call :intro
   echo:Can not find rescryptor executable
   call :hold
   goto end

:0xe00001
   call :intro
   echo:Can not find specified file types of .%_extension% and .%_extension2% 
   call :hold
   goto end

:fnc_decrypt
   %_decryptor% %_currentFile%
   goto end

:hold
   echo:
   echo:Press any key...
   pause > nul
   goto end

:intro
   echo:лллллллллллллллллллллллллллллллллллллллллллллллллллллл
   echo:л                                                    л
   echo:л                       mbnq.pl                      л
   echo:л                               Arisen Archlord      л
   echo:лллллллллллллллллллллллллллллллллллллллллллллллллллллл
   echo:
   goto end

:end
   :: 6d626e712e70