
$VM = "nicolepfusion"

    
      
    Get-Service -ComputerName $VM  -Name "nxlog"

    # Set-Service -ComputerName $VM -Name "NahimicService" -Status stopped -StartupType disabled

    