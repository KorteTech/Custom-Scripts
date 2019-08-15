#requires -version 2.0 
#use parameter  drive report to html.ps1 computer1,computer2 or a computer list file 
#change file path and name on line 7 below to reflect name and  path of computer list file using. 
#script will open web browser with current report when completed.  

Param (
 $computers = (Get-Content  "C:\DEV\Custom Scripts\Disk Space\Computers.txt")
)

$Title="Hard Drive Report to HTML"

#embed a stylesheet in the html header
 $head = "<Title>$Title</Title><br>"

#define an array for html fragments
 $fragments=@()

#get the drive data
 $data=Get-WmiObject -Class Win32_logicaldisk -filter "drivetype=3" -computer $computers

#group data by computername
 $groups=$Data | Group-Object -Property SystemName

#this is the graph character
[string]$g=[char]9608

#create html fragments for each computer
#iterate through each group object

ForEach ($computer in $groups) {
write-host $computer.Name
     $fragments+="<H2>$($computer.Name)</H2>"

     #define a collection of drives  from the group object
     $Drives=$computer.group


     
     #create an html fragment
     $html=$drives | Select @{Name="Drive";Expression={$_.DeviceID}},
     @{Name="SizeGB";Expression={$_.Size/1GB  -as [int]}},
     @{Name="UsedGB";Expression={"{0:N2}" -f (($_.Size - $_.Freespace)/1GB) }},
     @{Name="Free%";Expression={"{0:P2}" -f (($_.Size - ($_.Size - $_.Freespace))/$_.Size) }},
     @{Name="Usage";Expression={
       $UsedPer= (($_.Size - $_.Freespace)/$_.Size)*100
       $UsedGraph=$g * ($UsedPer/2)
       $FreeGraph=$g* ((100-$UsedPer)/2)
       #I'm using place holders for the < and > characters
       if ((($_.Size - ($_.Size - $_.Freespace))/$_.Size) -lt 30)
       {"xopenFont color=Redxclose{0}xopen/FontxclosexopenFont Color=Greenxclose{1}xopen/fontxclose" -f $usedGraph,$FreeGraph}
       else 
       {"xopenFont color=Yellowxclose{0}xopen/FontxclosexopenFont Color=Greenxclose{1}xopen/fontxclose" -f $usedGraph,$FreeGraph}
     }} |  ConvertTo-Html -Fragment

     #replace the tag place holders. It is a hack but it works.
     $html=$html -replace "xopen","<"
     $html=$html -replace "xclose",">"

     #add to fragments
     $Fragments+=$html

     #insert a return between each computer
     $fragments+="<br>"

} #foreach computer

#add a footer
 $footer=("<br><I>Report run {0} by {1}\{2}<I>" -f (Get-Date -displayhint date),$env:userdomain,$env:username)
  $fragments+=$footer

$Path = "\\192.168.1.54\Sites\intranet\DiskSpace.html"
  #write the result to a file
 ConvertTo-Html -head $head -body $fragments  | Out-File -filepath $Path
