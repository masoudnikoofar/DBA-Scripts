@echo off
echo open 172.50.251.220> D:\DB_Backup\Scripts\Trans_2.bat
echo ekm>> D:\DB_Backup\Scripts\Trans_2.bat
echo ekm_ftp>> D:\DB_Backup\Scripts\Trans_2.bat
echo lcd "D:\DB_Backup\EKM_App\Trans" >> D:\DB_Backup\Scripts\Trans_2.bat
echo cd Trans>> D:\DB_Backup\Scripts\Trans_2.bat
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c_%%a_%%b)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a)
echo mput *%mydate%_%mytime%*.trn>> D:\DB_Backup\Scripts\Trans_2.bat
echo bye>> D:\DB_Backup\Scripts\Trans_2.bat
ftp -i -v -s:D:\DB_Backup\Scripts\Trans_2.bat

Trans.vbs