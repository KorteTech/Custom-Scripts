

$dl=dir "\\TKCCLoud\cloudJobView\National" |?{$_.psiscontainer}
foreach ($d in $dl)
{

$FolderPath = $($d.fullname)
$Shares=[WMICLASS]'WIN32_Share' 
 
##'Subfolders and files only': "ContainerInherit, ObjectInherit", "InheritOnly"
##'This folder only': "None", "InheritOnly"

$acl = Get-Acl $FolderPath 

$acl.Access | % {$acl.purgeaccessrules($_.IdentityReference)}

$colRights = [System.Security.AccessControl.FileSystemRights]"Read,ExecuteFile,ListDirectory" 
$permission = "s KorteEmployees",$colRights,"ObjectInherit”,”None”,”Allow” 
$accessRule1 = New-Object System.Security.AccessControl.FileSystemAccessRule $permission  
$acl.AddAccessRule($accessRule1) 


$colRights = [System.Security.AccessControl.FileSystemRights]"Modify" 
$permission = "s KorteEmployees",$colRights,"ContainerInherit, ObjectInherit", ”InheritOnly”,”Allow” 
$accessRule2 = New-Object System.Security.AccessControl.FileSystemAccessRule $permission  
$acl.AddAccessRule($accessRule2) 


$colRights = [System.Security.AccessControl.FileSystemRights]"Modify" 
$permission = "s CJVAdmin",$colRights,"ContainerInherit, ObjectInherit", ”None”,”Allow” 
$accessRule3 = New-Object System.Security.AccessControl.FileSystemAccessRule $permission  
$acl.AddAccessRule($accessRule3) 


$colRights = [System.Security.AccessControl.FileSystemRights]"FullControl" 
$permission = "s Domain Admins",$colRights,"ContainerInherit, ObjectInherit", ”None”,”Allow” 
$accessRule4 = New-Object System.Security.AccessControl.FileSystemAccessRule $permission  
$acl.AddAccessRule($accessRule4) 

$acl.SetAccessRuleProtection($True,$False)

Set-Acl $FolderPath $acl

write $FolderPath

##Get-Acl $FolderPath | Format-List
}