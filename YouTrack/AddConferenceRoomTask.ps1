


$sqlServer='TKCBT'
$params = @{'server'='TKCBT';'Database'='Loggly'}

$Markdown = '

Conference Room monthly checkup:

| Room | Date Checked   | Issues |
| - | - | - |
| Illinois Room |             | |
| Missouri Room | | |
| Korte Room South | | |
| Korte Room North | | |
| Think Tank Room | | |
| 1958 Room | | |
| Ralph Korte Room | | |
| Frank Sinatra Room | | |
| Dean Martin Room | | |

Mac:

* Check for any updates
* Restart
* Connect to a zoom meeting and test audio and video

PC:

* Check for any updates, both online and local
* Restart
* Connect to zoom meeting and test screen sharing and audio

Echo dot:

* Verify all commands work as expected (Split, Mirror, Extend, Full) 
* Korte Room South Cable, Apple, TV on, TV off, On, Off
* Think Tank Room TV on, TV off, On, Off
* Illinois Room/Missouri Room On, Room Off, Displays on, Displays Off

TVs:

* Check for any updates
* Verify they are connected to the internet

Video Switcher:

* Verify you can manually change inputs

Lighting and Blinds:

* Rooms that have lighting control, verify the lights turn on and dim (if applicable)
* Rooms that have motorized blinds. Verify they move up and down as needed.

Stereo Receiver:

* Rooms with receivers, verify they power on with room and the initial volume is set. Also verify the input is correct.'




$Body = 
"{`"project`":{`"id`":`"81-0`"}
,`"summary`":`"Conference Room monthly check`"
,`"description`":`"Monthly maintenance checkup for all conference room equipment and software.`"
,`"customFields`":[
{ `"name`":`"Priority`",`"`$type`":`"SingleEnumIssueCustomField`",`"value`":{`"name`":`"Normal`"}},
{ `"name`": `"Assignee`",`"`$type`": `"SingleUserIssueCustomField`",`"value`": {`"login`":`"tara.spitze`"}},
{ `"name`": `"Type`",`"`$type`": `"SingleEnumIssueCustomField`",`"value`": {`"name`":`"Task`"}},
{ `"name`": `"Subsystem`",`"`$type`": `"SingleOwnedIssueCustomField`",`"value`": {`"name`":`"Conference Rooms`"}}
],
 `"text`": `" $Markdown `"}"

#Write-Output $Body

Invoke-sqlcmd @params -Query "exec Intranet.dbo.KorteAPIYouTrack '$Body'"

