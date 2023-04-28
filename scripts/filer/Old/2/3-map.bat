echo start %date% %time% >> diff.log
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c_%%a_%%b)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a)
set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
echo copy "F:\backup automatic filerplus\diff\filerwin_backup_*%mydate%_%hour%*.*" Z:\diff> F:\4.bat

4.bat
3.vbs
echo finish %date% %time% >> diff.log

