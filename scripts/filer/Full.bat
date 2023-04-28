@echo off
echo open 172.50.251.220> F:\DB_Backup\Scripts\Full_2.bat
echo filer>> F:\DB_Backup\Scripts\Full_2.bat
echo filer_ftp>> F:\DB_Backup\Scripts\Full_2.bat
echo cd Full>> F:\DB_Backup\Scripts\Full_2.bat
echo lcd "F:\DB_Backup\Full" >> F:\DB_Backup\Scripts\Full_2.bat
for /f "tokens=2-4 delims=/ " %%a in ('echo %date%') do echo mput *%%c_%%a_%%b*.bak>> F:\DB_Backup\Scripts\Full_2.bat
echo bye>> F:\DB_Backup\Scripts\Full_2.bat
ftp -i -v -s:F:\DB_Backup\Scripts\Full_2.bat

Full.vbs