$Computer = "tkcstl1"

Get-WmiObject -Namespace "root\cimv2" -Class Win32_Process -Impersonation 3 -Credential kcchi_d\intratesting -ComputerName $Computer