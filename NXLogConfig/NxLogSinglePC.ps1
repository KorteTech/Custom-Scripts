$VM = "FrankSinatraRoom"

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