#$Computers =  Get-ADComputer  -Filter {(enabled -eq "true") -and (OperatingSystem -Like "*server*")} | Select-Object -ExpandProperty Name
$Computers =  Get-ADComputer  -Filter {(enabled -eq "true")} | Select-Object -ExpandProperty Name
#$output=@()
ForEach($PSItem in $Computers) {

$stringOutput = quser /server:$PSItem 2>$null
      #If (!$stringOutput)
      #{
      #Write-Warning "Unable to retrieve quser info for `"$PSItem`""
      #}
#write-output $line
      ForEach ($line in $stringOutput){
         #If ($line -match "logon time") 
         #{Continue}
         if ($line.SubString(1, 20).Trim() = "jeremyreynolds")
            {
             [PSCustomObject]@{
              ComputerName    = $PSItem
              Username        = $line.SubString(1, 20).Trim()
              #SessionName     = $line.SubString(23, 17).Trim()
              ID             = $line.SubString(42, 2).Trim()
              State           = $line.SubString(46, 6).Trim()
              #Idle           = $line.SubString(54, 9).Trim().Replace('+', '.')
              #LogonTime      = [datetime]$line.SubString(65)
            }
          }
          
      } 

}