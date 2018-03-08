$gSrcDirName = "C:\logs"
$gDstDirName = "\\XX.XXX.X.XX\Backups"
$gDstDirNamePrefix = "backup-"

# creating directory with name like 
# backup-dd-mm-yyyy in gDstDirName
# for backuping files into int
function createDirectory {
	$curDate = Get-Date -UFormat "%d-%m-%y"
	if($gDstDirName.EndsWith("\")){
		$dstDirName = $gDstDirName+$gDstDirNamePrefix+$curDate
	}
	else {
		$dstDirName = $gDstDirName+"\"+$gDstDirNamePrefix+$curDate
	}
	$dirExists = Test-Path $dstDirName
	if($dirExists -eq $False) {
		New-Item $dstDirName -Type directory | Out-Null
	}
	return $dstDirName
}

# getting oldest directory in gDstDirName and
# recursevly removing it
function removeOldestBackup() {
    $oldesBackup = Get-ChildItem "$gDstDirName" | Sort CreationTime | Select -First 1
    echo "removing oldest backups" + $oldesBackup
    $oldesBackup | Remove-Item -recurse
}

# moving all files from gSrcDirName to gFinalDstDirName
# with robocopy command
function doBackup{
	robocopy /S /MOV "$gSrcDirName" "$gFinalDstDirName" /R:15 /W:10
}

# main scenario
try {
	$gFinalDstDirName = createDirectory
	if ($gDstDirName -ne "") {
		doBackup
	}
    removeOldestBackup
} catch {
	echo "Error while backuping files"
}
