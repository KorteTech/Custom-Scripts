
$VM = "MAGGIETAYLOR"

     Get-Service -ComputerName $VM |
            ? { $_.Name -match “nxlog” } 
      
    

    # Set-Service -ComputerName $VM -Name "NahimicService" -Status stopped -StartupType disabled

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
        
        Get-Service -ComputerName $VM  -Name "nxlog"