@echo off
setlocal
set old_cd=%cd%
if "%1%" EQU "/OnBoot" (
	set IsAdmin=FALSE
	goto ProgramBulk
) else (
	set IsAdmin=UNDEFINED
)
title Michael's Windows Maintainence Tasks
echo Michael's Windows Maintainence Tasks; Update of Mon 31 July 2017 18:59 AEST.
echo Copyright (C) 2017 Michael Miranda, all rights reserved.
echo.
if "%1%" EQU "/?" (
	echo Description: An automated utility to clean up unwanted files.
	echo To make this program perform the automation, run with no parameters.
	echo.
	if "%2%" EQU "/ForceArgumentDocumentation" (
		echo Argument /ForceArgumentDocumentation:
		echo 	User: %username%
		echo 	Computer ID: %computername%
		echo 	Date: %date%
		echo 	Time: %time%;
		echo.
		goto StillNotify
	)
	echo Note: This program now refuses to document it's arguments at the command
	echo line to avoid unintented usage and/or hacking technquies.
	goto EndProgram
	: StillNotify
	echo Command Line Options:
	echo.
	echo [	/OnBoot: Perform a startup clean, assume no admin.
	echo [	^/^?^: Display this help message, this option shouldn't exist.
	echo.
	echo Note: This program is not for command line execution, but a simple command
	echo 	script for maintaining a windows pc. These options should not be used
	echo 	unless a level of automation is in place.
	echo.
	pause
	cls
	echo Command Finished
	goto EndProgram
)
if /i "%cd%" NEQ "C:\WINDOWS\System32" (
	set IsAdmin=FALSE
) else (
	set IsAdmin=TRUE
)
: ProgramBulk
chdir "%homepath%"
echo To begin, a call is made to the Disk Cleanup Utility...
call cleanmgr.exe /AUTOCLEAN
if exist "C:\Program Files\CCleaner\CCleaner.exe" (
	echo.
	echo Your computer has CCleaner installed, calling your CCleaner...
	if exist "C:\Program Files\CCleaner\CCleaner64.exe" (
		call "C:\Program Files\CCleaner\CCleaner64.exe" /AUTO
	) else (
		call "C:\Program Files\CCleaner\CCleaner.exe" /AUTO
	)
)
echo.
echo Attempting to clear your recent list...
pushd "%homepath%\Recent"
set /a filenum=1
for %%f in (*.*) do set /a filenum=1+%filenum%
if "%filenum%" LSS "2" (
	echo Your recent list is empty, operation aborted.
	goto RecentDone
)
del *.* /Q /S > NUL
set /a filenum=%filenum%-1
echo Your recent list had %filenum% entries that have been deleted.
: RecentDone
popd
echo.
if "%IsAdmin%" EQU "FALSE" (
	echo This program cannot perform the last programmed task because it must
	echo have administrative rights.	
	echo.
	pause
	goto EndProgram
)
echo To finish up, a defragmentation is performed on all disks...
defrag /D /C > NUL
if "%errorlevel%" NEQ "0" (
	echo.
	echo The MS Defrag Utility failed, maybe you don't have admin rights?
	pause
	exit /b 1
)
goto EndProgram
rem Subprograms Start
rem Subprograms End
: EndProgram
title %comspec%
chdir %old_cd%
if "%1%" EQU "/OnBoot" (
	exit
)