import-module activedirectory

$vmlist = Get-ADComputer -Filter * -SearchBase "OU=Servers, DC=korteco, DC=com"

#get-module -listavailable

#Get-ADComputer -Filter *

foreach($VM in $VMlist) {
    Write-Output $VM.Name
}



$list = Get-ADComputer -Filter * -SearchBase "CN=Computers, DC=korteco, DC=com"


foreach($PC in $list) {
    Write-Output $PC.Name
}