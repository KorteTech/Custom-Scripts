param([string]$FolderName)

Write-Output "test1";
Write-Host "test2";


$FolderPath = '\\TKCLV\KorteJobView-LV' 
##+ $FolderName
##FayetteCountyHospLabAddition_40655'  
$Shares=[WMICLASS]'WIN32_Share' 
 
##'Subfolders and files only': "ContainerInherit, ObjectInherit", "InheritOnly"
##'This folder only': "None", "InheritOnly"

foreach ($FolderName in $FolderPath) {
    $Path = $FolderName.FullName
    Write-Output $Path
    $acl = Get-Acl $Path 
    $colRights = [System.Security.AccessControl.FileSystemRights]"FullControl" 
    $permission = "SYSTEM",$colRights,"ContainerInherit, ObjectInherit", ”None”,”Allow” 
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission  
    $acl.AddAccessRule($accessRule) 


    Set-Acl $Path $acl

    ##Get-Acl $FolderPath | Format-List
}