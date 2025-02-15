$OneDrive = [System.Environment]::GetEnvironmentVariable("OneDriveConsumer")
$Backups = "Backups"
$BackupDirectory = $OneDrive + "\" + $Backups

if (-not (Test-Path -Path $BackupDirectory)) {
    New-Item -Path $BackupDirectory -ItemType Directory -Name $Backups
}

Set-Variable -Option Constant -Name "Config" -Value (Get-Content -Path ($BackupDirectory + "\config.json") | ConvertFrom-Json -AsHashtable)

$DateFormat = "yy_MMdd_hhmm"

$Date = Get-Date -Format $DateFormat

$Date

$Config

# First loop through config names and make sure directory exists
# Then check if the directory is empty, if there is something in the directory take the latest modified item
# Hash that save with the current save, do not create a new backup if the saves are exactly the same.
# If the saves are different, append the date to the file and save it as a backup