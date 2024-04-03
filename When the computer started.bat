@echo off
setlocal enabledelayedexpansion

REM How does the script work?
REM When the script is run, it downloads the date and time and saves it to a TXT file.
REM When the script runs later than the designated time, it adds information about the anomaly.
REM When the script is run at the appropriate times, it gives information that everything is OK.
REM The data file is saved on the "D" drive.

REM Installation: 
REM 1. Press Windows + [R] enter the command "shell:startup" and confirm with enter.
REM 2. After executing the above command, a folder will appear. Copy the script and then paste it into the open folder.

REM IF YOU DID EVERYTHING CORRECTLY, THE SCRIPT WILL RUN EVERY TIME YOU START YOUR COMPUTER AND SAVE THE DATA TO A FILE.

set "file=D:\When the computer started - log.txt"
set "datestamp=%date%"
set "timestamp=%time%"
set "custom_hour=16"
set "custom_minute=30"
set "info="

REM Checking if the startup time is at the specified time in the custom_hour and custom_minute variables
for /f "tokens=1-3 delims=: " %%a in ("%time%") do (
    set /a "hour=%%a"
    set /a "minute=%%b"
    set /a "second=%%c"
)

if !hour! lss !custom_hour! (
    set "info=OK"
) else if !hour! equ !custom_hour! (
    if !minute! lss !custom_minute! (
        set "info=OK"
    ) else (
        set "info=Warning!"
    )
) else (
    set "info=Warning!"
)

REM Time format repair:
REM If the number of hours, minutes or seconds is less than 10, add 0 before it. So that each position in the hour is a two-digit number.
if !hour! lss 10 set "hour=0!hour!"
if !minute! lss 10 set "minute=0!minute!"
if !second! lss 10 set "second=0!second!"

REM Format time into hours, minutes, seconds.
set "timestamp=!hour!:!minute!:!second!"

REM Creating or updating a TXT file.
if not exist "%file%" (
    echo Start date,Start time,Status > "%file%"
) 

echo %datestamp%,!timestamp!,%info% >> "%file%"

endlocal
