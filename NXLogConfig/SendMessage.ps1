#$name = read-host "Enter computer name "
#$msg = read-host "Enter your message "
#Invoke-WmiMethod -Path Win32_Process -Name Create -ArgumentList "msg * $msg" -ComputerName $name

$name = 'barryvm10pro'
$msg = 'test for barry'
Invoke-WmiMethod -Path Win32_Process -Name Create -ArgumentList "msg * $msg" -ComputerName $name


$name = 'nicolepmbpvm'
$msg = 'test for barry'
Invoke-WmiMethod -Path Win32_Process -Name Create -ArgumentList "msg * $msg" -ComputerName $name

$name = '10.10.37.21'
$msg = 'test for barry'
Invoke-WmiMethod -Path Win32_Process -Name Create -ArgumentList "msg * $msg" -ComputerName $name