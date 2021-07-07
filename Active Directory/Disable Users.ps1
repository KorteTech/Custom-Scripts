 # disableUsers.ps1  
# Set msDS-LogonTimeSyncInterval (days) to a sane number.  By
# default lastLogonDate only replicates between DCs every 9-14 
# days unless this attribute is set to a shorter interval.
 
# Also, make sure to create the EventLog source before running, or
# comment out the Write-EventLog lines if no event logging is
# needed.  Only needed once on each machine running this script.
# New-EventLog -LogName Application -Source "DisableUsers.ps1"
 
# Remove "-WhatIf"s before putting into production.

$sqlServer='TKCBT'
$params = @{'server'='TKCBT';'Database'='Loggly'}
Import-Module ActiveDirectory

$DisableList = ""
$inactiveDays = 60
$neverLoggedInDays = 60
$disableDaysInactive=(Get-Date).AddDays(-($inactiveDays))
$disableDaysNeverLoggedIn=(Get-Date).AddDays(-($neverLoggedInDays))
 
# Identify and disable users who have not logged in in x days
 
$disableUsers1 = Get-ADUser -SearchBase "CN=Users,DC=korteco,DC=com" -Filter {Enabled -eq $TRUE} -Properties lastLogonDate, whenCreated, distinguishedName | Where-Object {($_.lastLogonDate -lt $disableDaysInactive) -and ($_.lastLogonDate -ne $NULL)}
 
 $disableUsers1 | ForEach-Object {
 Write-Output "Attempted to disable user $_ because the last login was more than $inactiveDays days ago."
$DisableList = $DisableList + "Disabled user $_ because the last login was more than $inactiveDays days ago. </br>"
   #Disable-ADAccount $_ -WhatIf
   ##Write-Output -Source "DisableUsers.ps1" -EventId 9090 -LogName Application -Message "Attempted to disable user $_ because the last login was more than $inactiveDays ago."
   }
 
# Identify and disable users who were created x days ago and never logged in.
 
$disableUsers2 = Get-ADUser -SearchBase "CN=Users,DC=korteco,DC=com" -Filter {Enabled -eq $TRUE} -Properties lastLogonDate, whenCreated, distinguishedName | Where-Object {($_.whenCreated -lt $disableDaysNeverLoggedIn) -and (-not ($_.lastLogonDate -ne $NULL))}
 Write-Output " "
$disableUsers2 | ForEach-Object {
    Write-Output "Attempted to disable user $_ because user has never logged in and $neverLoggedInDays days have passed."
    $DisableList = $DisableList + "Disabled user $_ because user has never logged in and $neverLoggedInDays days have passed. </br>"
   #Disable-ADAccount $_ -WhatIf
   ##Write-Output -Source "DisableUsers.ps1" -EventId 9091 -LogName Application -Message "Attempted to disable user $_ because user has never logged in and $neverLoggedInDays days have passed."
   }

$DisableList = $DisableList.Replace("\","slash").Replace(":","colon")

$Body = 
"{`"project`":{`"id`":`"81-0`"}
,`"summary`":`"Audit task: Disable Inactive Users`"
,`"description`":`"The users listed in the comment below have not logged in.`"
,`"customFields`":[
{ `"name`":`"Priority`",`"`$type`":`"SingleEnumIssueCustomField`",`"value`":{`"name`":`"Normal`"}},
{ `"name`": `"Assignee`",`"`$type`": `"SingleUserIssueCustomField`",`"value`": {`"login`":`"dan.kapp`"}},
{ `"name`": `"Type`",`"`$type`": `"SingleEnumIssueCustomField`",`"value`": {`"name`":`"Auditing Failures`"}},
{ `"name`": `"Subsystem`",`"`$type`": `"SingleOwnedIssueCustomField`",`"value`": {`"name`":`"System Security`"}}
],
 `"text`": `" $DisableList `"}"

Write-Output $Body

# Only send if there were any users disabled
if ($DisableList.length -gt 10) {
    Invoke-sqlcmd @params -Query "exec Intranet.dbo.KorteAPIYouTrack '$Body'"
} 
