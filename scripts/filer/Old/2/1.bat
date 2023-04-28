echo %date% >> full.log
echo start >> full.log
echo open 172.50.251.220> F:\2.bat
echo nikoofar>> F:\2.bat
echo masoud1987>> F:\2.bat
echo lcd "F:\backup automatic filerplus\full" >> F:\2.bat
echo cd DBS>> F:\2.bat
echo cd filer>> F:\2.bat
for /f "tokens=2-4 delims=/ " %%a in ('echo %date%') do echo mput *%%c_%%a_%%b*.bak>> F:\2.bat
echo bye>> F:\2.bat