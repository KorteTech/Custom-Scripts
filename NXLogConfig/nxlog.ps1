$vmlist = Get-Content C:\Github\KorteTech\Custom-Scripts\NXLogConfig\VMs.txt
foreach($VM in $VMlist) {
    Write-Output $VM

    switch ($VM)
    {
     {($_ -eq "TKCDATA") -or ($_ -eq "TKCBACKUPS")} {
        Copy-Item -Path "\\kortedata\departments\Technologies\Installs\nxlog\Server Config\logs-01.loggly.com_sha12.crt" -Destination "\\$VM\c$\Program Files\nxlog\cert\logs-01.loggly.com_sha12.crt"
        Copy-Item -Path "\\kortedata\departments\Technologies\Installs\nxlog\Server Config\nxlog.conf" -Destination "\\$VM\c$\Program Files\nxlog\conf\nxlog.conf"
        Stop-Service -Name "nxlog"
        Start-Sleep -s 5
        Start-Service -Name "nxlog"
        Start-Sleep -s 5
        }
    default {
        Copy-Item -Path "\\kortedata\departments\Technologies\Installs\nxlog\Server Config\logs-01.loggly.com_sha12.crt" -Destination "\\$VM\c$\Program Files (x86)\nxlog\cert\logs-01.loggly.com_sha12.crt"
        Copy-Item -Path "\\kortedata\departments\Technologies\Installs\nxlog\Server Config\nxlog.conf" -Destination "\\$VM\c$\Program Files (x86)\nxlog\conf\nxlog.conf"
    
        try {
            Get-Service -ComputerName $VM |
            ? { $_.Name -match “nxlog” } | % {
                $_.Stop()
                $_.WaitForStatus('Stopped','00:00:05')
                }
            }
            catch {
                "NxLog service was not running and could not be stopped."
            }

        try {
            Get-Service -ComputerName $VM |
            ? { $_.Name -match “nxlog” } | % {
                $_.Start()
                $_.WaitForStatus('running','00:00:05')
                }        
            }
            catch {
                "NxLog service could not be started."
            } 
        }
    }
}



