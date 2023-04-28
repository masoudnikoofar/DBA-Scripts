echo %date% >> diff.log
echo start >> diff.log
echo open 172.50.251.220> F:\4.bat
echo nikoofar>> F:\4.bat
echo masoud1987>> F:\4.bat
echo lcd "F:\backup automatic filerplus\diff" >> F:\4.bat
echo cd DBS>> F:\4.bat
echo cd filer>> F:\4.bat
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c_%%a_%%b)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a)
set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
echo mput *%mydate%_%hour%*.*>> F:\4.bat

echo bye>> F:\4.bat

