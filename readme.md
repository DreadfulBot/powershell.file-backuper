# POWERSHELL FILE-BACKUPER
### FOR WHAT?
For moving backup files in systems, where backups makes, for example, 1 time in a week, backup files stored locally and needs to be move to centralized backup storage.
In my case, this script were used for moving MSSQL Database backup files, which were created by MSSQL Server agent to the local drive, to the remote server. Second case – moving Sharepoint logs from local drive to remote storage.
### HOW?
* Script creates folder with name by mask like “backup-%current-date%” in destination folder
* Script moves all files from local source folder to new created folder in destination folder
* Script removes oldest directory from destination folder if operation were finished successfully
### HOW TO USE
There are 3 parameters in script that you must set before script execution. 
```
$gSrcDirName = "C:\logs" #source path, from where files will be moved
$gDstDirName = \\XX.XXX.X.XX\Backups #destination path, where new backup-folder will be created and your file from destination folder will be moved in
$gDstDirNamePrefix = "backup-" #prefix for name of backup-folder
```
Feel free to set your custom values for your needs. As you can see, *$gDstDirName* were UNC-path and script works with in correctly.
### CREDITS
Zorg1995@yandex.ru
Krivoshchekov Artem
