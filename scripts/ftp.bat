color 20
SET FTP_SERVER = 172.50.251.220
SET FTP_USERNAME = nikoofar
SET FTP_PASSWORD = masoud1987

call :PARAMTEST "masoud"

:PARAMTEST
ECHO. && CALL :MP 1 "PARAMTEST CALLED WITH: %*" && ECHO %L1%
SET _P= %~1
IF NOT "%_P%" == " " ( ECHO %%1          = %1 && ECHO %%~f1        = %~f1 && ECHO %%~d1        = %~d1 && ECHO %%~p1        = %~p1
  ECHO %%~n1        = %~n1 && ECHO %%~x1        = %~x1 && ECHO %%~s1        = %~s1 && ECHO %%~dp1       = %~dp1
  ECHO %%~nx1       = %~nx1 && ECHO %%~$PATH:1   = %~$PATH:1 && ECHO %%~dp$PATH:1 = %~dp$PATH:1 && ECHO %L1% )
SET _P= %~2
IF NOT "%_P%" == " " ( ECHO %%2          = %2 && ECHO %%~f2        = %~f2 && ECHO %%~d2        = %~d2 && ECHO %%~p2        = %~p2
  ECHO %%~n2        = %~n2 && ECHO %%~x2        = %~x2 && ECHO %%~s2        = %~s2 && ECHO %%~dp2       = %~dp2
  ECHO %%~nx2       = %~nx2 && ECHO %%~$PATH:2   = %~$PATH:2 && ECHO %%~dp$PATH:2 = %~dp$PATH:2 && ECHO %L1% )
SET _P= %~3
IF NOT "%_P%" == " " ( ECHO %%3          = %3 && ECHO %%~f3        = %~f3 && ECHO %%~d3        = %~d3 && ECHO %%~p3        = %~p3
  ECHO %%~n3        = %~n3 && ECHO %%~x3        = %~x3 && ECHO %%~s3        = %~s3 && ECHO %%~dp3       = %~dp3
  ECHO %%~nx3       = %~nx3 && ECHO %%~$PATH:3   = %~$PATH:3 && ECHO %%~dp$PATH:3 = %~dp$PATH:3 && ECHO %L1% )
SET _P= %~4
IF NOT "%_P%" == " " ( ECHO %%4          = %4 && ECHO %%~f4        = %~f4 && ECHO %%~d4        = %~d4 && ECHO %%~p4        = %~p4
  ECHO %%~n4        = %~n4 && ECHO %%~x4        = %~x4 && ECHO %%~s4        = %~s4 && ECHO %%~dp4       = %~dp4
  ECHO %%~nx4       = %~nx4 && ECHO %%~$PATH:4   = %~$PATH:4 && ECHO %%~dp$PATH:4 = %~dp$PATH:4 && ECHO %L1% )
SET _P= %~5
IF NOT "%_P%" == " " ( ECHO %%5          = %5 && ECHO %%~f5        = %~f5 && ECHO %%~d5        = %~d5 && ECHO %%~p5        = %~p5
  ECHO %%~n5        = %~n5 && ECHO %%~x5        = %~x5 && ECHO %%~s5        = %~s5 && ECHO %%~dp5       = %~dp5
  ECHO %%~nx5       = %~nx5 && ECHO %%~$PATH:5   = %~$PATH:5 && ECHO %%~dp$PATH:5 = %~dp$PATH:5 && ECHO %L1% )
SET _P= %~6
IF NOT "%_P%" == " " ( ECHO %%6          = %6 && ECHO %%~f6        = %~f6 && ECHO %%~d6        = %~d6 && ECHO %%~p6        = %~p6
  ECHO %%~n6        = %~n6 && ECHO %%~x6        = %~x6 && ECHO %%~s6        = %~s6 && ECHO %%~dp6       = %~dp6
  ECHO %%~nx6       = %~nx6 && ECHO %%~$PATH:6   = %~$PATH:6 && ECHO %%~dp$PATH:6 = %~dp$PATH:6 && ECHO %L1% )
SET _P= %~7
IF NOT "%_P%" == " " ( ECHO %%7          = %7 && ECHO %%~f7        = %~f7 && ECHO %%~d7        = %~d7 && ECHO %%~p7        = %~p7
  ECHO %%~n7        = %~n7 && ECHO %%~x7        = %~x7 && ECHO %%~s7        = %~s7 && ECHO %%~dp7       = %~dp7
  ECHO %%~nx7       = %~nx7 && ECHO %%~$PATH:7   = %~$PATH:7 && ECHO %%~dp$PATH:7 = %~dp$PATH:7 && ECHO %L1% )
CALL :MF
EXIT /B



REM =========================================================================================================================================================================
REM =   PARAMTESTHELP - show params help, then returns to CALLer
REM =========================================================================================================================================================================
:PARAMTESTHELP
ECHO %%~1 Expands %%1 and removes any surrounding quotation marks
ECHO %%~f1 Expands %%1 to a fully qualified path name.
ECHO %%~d1 Expands %%1 to a drive letter.
ECHO %%~p1 Expands %%1 to a path.
ECHO %%~n1 Expands %%1 to a file name.
ECHO %%~x1 Expands %%1 to a file extension.
ECHO %%~s1 Expanded path contains short names only.
ECHO %%~a1 Expands %%1 to file attributes.
ECHO %%~t1 Expands %%1 to date and time of file.
ECHO %%~z1 Expands %%1 to size of file.
ECHO %%~dp1 Expands %%1 to a drive letter and path.
ECHO %%~nx1 Expands %%1 to a file name and extension.
ECHO %%~ftza1 Expands %%1 to a dir-like output line.
ECHO %%~$PATH:1 Searches the dirs in PATH expanding %%1 to fully qualified name of first found. If var name isn't defined or the files not found, expands to empty string.
ECHO %%~dp$PATH:1 Searches the directories listed in the PATH environment variable for %%1 and expands to the drive letter and path of the first one found.
CALL :MF
EXIT /B






REM =========================================================================================================================================================================
REM =   EXAMINEFILE - FINDs useful strings in file, then returns to CALLer
REM =========================================================================================================================================================================
:EXAMINEFILE
CALL :MP 1 "Examine File %~1"
CALL :EXISTORQUIT "%~1"
STRINGS "%~1" | FINDSTR /R /C:"[A-Z][A-Z]\="
CALL :MF
EXIT /B

REM =========================================================================================================================================================================
REM =   ADMINSHELL - sets prompt, then returns to CALLer
REM =========================================================================================================================================================================
:ADMINSHELL
CALL :MP 1 "Creating Admin Shell"
CALL :EXISTORQUIT "%SYSTEMROOT%\system32\runas.exe"
START %SYSTEMROOT%\system32\runas.exe /profile /savecred /user:%ADMINUSER% "%COMSPEC% /T:0C /E:ON /F:ON /K cmd.exe /K cd C:\CRYPT\BIN"
CALL :MF
EXIT /B

:MF
ECHO  [COMPLETED] && ECHO. && ECHO. && EXIT /B

REM =========================================================================================================================================================================
REM =   MM - prints blank line, L1, changes title of the interpreter window to %~1, prints >>> %~1..., L2, blank line, then returns to CALLer
REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
REM
REM     +==============================================================================================================+
REM     >>> Title Changed To This...
REM     +--------------------------------------------------------------------------------------------------------------+
REM
REM =========================================================================================================================================================================
:MM
ECHO. && ECHO %L1% && title +++ %~1... && ECHO %P1% %~1... && ECHO %L2% && ECHO. && EXIT /B

REM =========================================================================================================================================================================
REM =   MT - prints blank line, L1, changes title of the interpreter window to %~1, prints >>> %~1..., L2, blank line, then returns to CALLer
REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
REM
REM     +==============================================================================================================+
REM     >>> Title Changed To This...
REM     +--------------------------------------------------------------------------------------------------------------+
REM
REM =========================================================================================================================================================================
:MT
CALL :MM "%~1" && CALL :SPEAK "%~1" && EXIT /B

REM =========================================================================================================================================================================
REM =   MP - , then returns to CALLer
REM -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
REM
REM     P1=>>>
REM     P2=++
REM     P3=::
REM
REM =========================================================================================================================================================================
:MP
IF "%~1" == "1" ECHO %P1% %~2 && EXIT /B
IF "%~1" == "2" ECHO %P2% %~2 && ECHO. && EXIT /B
IF "%~1" == "3" ECHO %P3% %~2 && EXIT /B
EXIT /B

REM =========================================================================================================================================================================
REM =   MP3 - ECHO %~1, speak %~1 with nircmd.exe, then returns to CALLer
REM =========================================================================================================================================================================
:MP3
CALL :MP 1 "%~1" && CALL :SPEAK "%~1" && EXIT /B


REM =========================================================================================================================================================================
REM =   MDYE - exit script with message %~1, then returns to CALLer
REM =========================================================================================================================================================================
:MDYE
SETLOCAL
SET _M= %~1
IF NOT "%_M%" == " " SET _M=REASON: %~1
CALL :MP 1 "EXITING SCRIPT...  %_M%" && ECHO. && ECHO.
ENDLOCAL && EXIT /B


REM =========================================================================================================================================================================
REM =   MKILL - exit cmd processor with message %~1
REM =========================================================================================================================================================================





