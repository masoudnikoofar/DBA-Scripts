@echo off
echo open 172.50.251.220> D:\DB_Backup\Scripts\Full_2.bat
echo ekm>> D:\DB_Backup\Scripts\Full_2.bat
echo ekm_ftp>> D:\DB_Backup\Scripts\Full_2.bat
echo cd Full>> D:\DB_Backup\Scripts\Full_2.bat
echo lcd "D:\DB_Backup\EKM_App\Full" >> D:\DB_Backup\Scripts\Full_2.bat
for /f "tokens=2-4 delims=/ " %%a in ('echo %date%') do echo mput *%%c_%%a_%%b*.bak>> D:\DB_Backup\Scripts\Full_2.bat
echo bye>> D:\DB_Backup\Scripts\Full_2.bat
ftp -i -v -s:D:\DB_Backup\Scripts\Full_2.bat

Full.vbs