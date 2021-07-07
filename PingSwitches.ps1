#@("192.168.1.96","192.168.2.36") | ForEach {Write-Host $_, "-", ([System.Net.NetworkInformation.Ping]::new().Send($_)).Status}

#192.168.1.96	Illinois Room
#192.168.2.36	1958 Room
#192.168.2.38	Ralph Korte Boardroom
#192.168.4.6	Korte Room South
#192.168.3.27	Frank Sinatra Room
#192.168.3.23	Dean Martin Room
#192.168.4.11	Think Tank Room

$ipaddresses = @("192.168.1.96","192.168.2.36","192.168.2.38","192.168.4.6","192.168.3.27","192.168.3.23","192.168.4.11")

foreach( $ip in $ipaddresses) {
    if (test-connection $ip -count 1 -quiet) {
        write-host $ip "Ping succeeded." -foreground green

    } else {
         write-host $ip "Ping failed." -foreground red
    }
    
}

Write-Host "Pinging Completed."