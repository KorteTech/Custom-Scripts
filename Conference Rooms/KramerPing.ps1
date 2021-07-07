#192.168.4.3	Korte Room South Epson Projector
#192.168.4.4	Korte Room South Epson Projector
#192.168.4.14	Think Tank Room	Epson Projector
#192.168.4.5	Korte Room North Epson Projector
#192.168.3.24	Dean Martin Room Epson Projector
#192.168.3.25	Dean Martin Room Epson Projector
#192.168.4.11	Think Tank Room	Kramer Switch
#192.168.3.27	Frank Sinatra Room Kramer Switch
#192.168.3.23	Dean Martin Room Kramer Switch
#192.168.1.96	Illinois Room Kramer Switch
#192.168.2.36	1958 Room Kramer Switch
#192.168.2.38	Ralph Korte Boardroom Kramer Switch
#192.168.4.6	Korte Room South Kramer Switch
#192.168.9.13	Illinois Room Mac
#192.168.2.152	1958 Room Mac
#192.168.9.11	Korte Room South Mac
#192.168.9.12	Korte Room North Mac
#192.168.9.14	Think Tank Room	Mac
#192.168.3.28	Dean Martin Room Mac
#192.168.3.30	Frank Sinatra Room Mac
#192.168.2.42	1958 Room Sony TV
#192.168.2.43	1958 Room Sony TV
#192.168.1.230	Barry's Office Sony TV
#192.168.9.15	Illinois Room Sony TV
#192.168.9.16	Illinois Room Sony TV
#192.168.3.31	Frank Sinatra Room Sony TV
#192.168.3.32	Frank Sinatra Room Sony TV
#192.168.9.17	Korte Room South Sony TV
#192.168.9.9	Think Tank Room	Yamaha Receiver
#192.168.9.10	Korte Room South Yamaha Receiver


$sqlServer='TKCBT'
$params = @{'server'='TKCBT';'Database'='Intranet'}

#$rooms = @( @{Name="Illinois Room Kramer switch";    IP="192.168.1.96"},
            #@{Name="1958 Room Kramer switch";   IP="192.168.2.36"},
            #@{Name="Korte Room South Kramer switch";   IP="192.168.4.6"},
            #@{Name="Frank Sinatra Room Kramer switch";   IP="192.168.3.27"},
            #@{Name="Dean Martin Room Kramer switch";   IP="192.168.3.23"},            
            #@{Name="Ralph Korte Boardroom Kramer switch"; IP="192.168.2.38"} )
$equipment = @(
@{IP="192.168.4.3";   Name="Korte Room South Epson Projector left"},
@{IP="192.168.4.4";   Name="Korte Room South Epson Projector right"},
@{IP="192.168.4.14";  Name="Think Tank Room	Epson Projector"},
@{IP="192.168.4.5";   Name="Korte Room North Epson Projector"},
@{IP="192.168.3.24";  Name="Dean Martin Room Epson Projector left"},
@{IP="192.168.3.25";  Name="Dean Martin Room Epson Projector right"},
@{IP="192.168.4.11";  Name="Think Tank Room	Kramer Switch"},
@{IP="192.168.3.27";  Name="Frank Sinatra Room Kramer Switch"},
@{IP="192.168.3.23";  Name="Dean Martin Room Kramer Switch"},
@{IP="192.168.1.96";  Name="Illinois Room Kramer Switch"},
@{IP="192.168.2.36";  Name="1958 Room Kramer Switch"},
@{IP="192.168.2.38";  Name="Ralph Korte Boardroom Kramer Switch"},
@{IP="192.168.4.6";   Name="Korte Room South Kramer Switch"},
#@{IP="192.168.9.13";  Name="Illinois Room Mac"},
#@{IP="192.168.2.152"; Name="1958 Room Mac"},
#@{IP="192.168.9.11";  Name="Korte Room South Mac"},
#@{IP="192.168.9.12";  Name="Korte Room North Mac"},
#@{IP="192.168.9.14";  Name="Think Tank Room	Mac"},
#@{IP="192.168.3.28";  Name="Dean Martin Room Mac"},
#@{IP="192.168.3.30";  Name="Frank Sinatra Room Mac"},
#@{IP="192.168.2.42";  Name="1958 Room Sony TV 1"},
#@{IP="192.168.2.43";  Name="1958 Room Sony TV 2"},
#@{IP="192.168.1.230"; Name="Barrys Office Sony TV"},
#@{IP="192.168.9.15";  Name="Illinois Room Sony TV 1"},
#@{IP="192.168.9.16";  Name="Illinois Room Sony TV 2"},
#@{IP="192.168.3.31";  Name="Frank Sinatra Room Sony TV 1"},
#@{IP="192.168.3.32";  Name="Frank Sinatra Room Sony TV 2"},
#@{IP="192.168.9.17";  Name="Korte Room South Sony TV"},
@{IP="192.168.9.9";   Name="Think Tank Room	Yamaha Receiver"},
@{IP="192.168.9.10";  Name="Korte Room South Yamaha Receiver"})


$out = ""

Write-Host "Started Pinging.."
foreach($eq in $equipment) {
    if (test-connection $eq.("IP") -count 1 -quiet) {
        #write-host $room.("Name") "Ping succeeded." -foreground green
        #$out = $out + $room.("Name") + " ping succeeded. </br>"

    } else {
        $out = $out + $eq.("Name") + " ping failed. </br>`n"
        #write-host $room.("Name") "ping failed." -foreground red
    }
    
}

#Write-Host $out #"Pinging Completed."

# Only send if there were any ping failures
if ($out.length -gt 1) {
    $cmd = "select dbo.[sendEmailHTML] ('donotreply@korteco.com', 'barry.kauhl@korteco.com','Conference room ping','" + $out + "','')"
    #write-host $cmd
    Invoke-sqlcmd @params -Query $cmd
    }
 
