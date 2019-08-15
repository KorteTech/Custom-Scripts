$computer = Get-WmiObject Win32_ComputerSystem 
$computer.UnjoinDomainOrWorkGroup("ch34pSn4k3", "Admin", 0) 
$computer.JoinDomainOrWorkGroup("korteco", "ch34pSn4k3", "Admin", $null, 3) 
Restart-Computer -Force