echo open 172.50.251.220> F:\4.bat
echo nikoofar>> F:\4.bat
echo masoud1987>> F:\4.bat
echo lcd "F:\backup automatic filerplus\diff" >> F:\4.bat
echo cd DBS>> F:\4.bat
echo cd filer>> F:\4.bat
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c_%%a_%%b)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a)
echo mput *%mydate%_%mytime%*.*>> F:\4.bat

echo bye>> F:\4.bat
ftp -i -v -s:F:\4.bat

3.vbs