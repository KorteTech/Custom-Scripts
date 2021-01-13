
$VM = "marcomerchiori"

    
      
    Get-Service -ComputerName $VM  -Name "NahimicService"

    # Set-Service -ComputerName $VM -Name "NahimicService" -Status stopped -StartupType disabled

    