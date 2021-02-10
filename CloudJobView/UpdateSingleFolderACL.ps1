$FolderPath = '\\tkccloud\cloudjobview\National\_National Small Jobs\26697_UOH5 Amazon Refrigeration Go-Back Project, Cincinnati OH'

$Shares=[WMICLASS]'WIN32_Share' 

##Get-ChildItem $FolderPath | Where-Object { $_.PSIsContainer } | ForEach-Object {
    
    $JobFolderPath = $FolderPath
    Write-Output $JobFolderPath

    Write-Output "Apply ACLs to parent folder"
    ##'Subfolders and files only': "ContainerInherit, ObjectInherit", "InheritOnly"
    ##'This folder only': "None", "InheritOnly"



    ##$acl = Get-Acl $JobFolderPath 

    $acl = New-Object System.Security.AccessControl.DirectorySecurity
    $acl.SetAccessRuleProtection($true,$false)

    $colRights = [System.Security.AccessControl.FileSystemRights]"Read,ExecuteFile,ListDirectory" 
    $permission = "s KorteEmployees",$colRights,"ObjectInherit”,”None”,”Allow” 
    $accessRule1 = New-Object System.Security.AccessControl.FileSystemAccessRule $permission  
    $acl.AddAccessRule($accessRule1) 


    ##'$colRights = [System.Security.AccessControl.FileSystemRights]"Modify" 
    ##'$permission = "s KorteEmployees",$colRights,"ContainerInherit, ObjectInherit", ”InheritOnly”,”Allow” 
    ##'$accessRule2 = New-Object System.Security.AccessControl.FileSystemAccessRule $permission  
    ##$'acl.AddAccessRule($accessRule2) 


    $colRights = [System.Security.AccessControl.FileSystemRights]"Modify" 
    $permission = "s CJVAdmin",$colRights,"ContainerInherit, ObjectInherit", ”None”,”Allow” 
    $accessRule3 = New-Object System.Security.AccessControl.FileSystemAccessRule $permission  
    $acl.AddAccessRule($accessRule3) 


    $colRights = [System.Security.AccessControl.FileSystemRights]"FullControl" 
    $permission = "s Domain Admins",$colRights,"ContainerInherit, ObjectInherit", ”None”,”Allow” 
    $accessRule4 = New-Object System.Security.AccessControl.FileSystemAccessRule $permission  
    $acl.AddAccessRule($accessRule4) 

    ##Write-Output ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
    
    Set-Acl $JobFolderPath $acl
    Clear-Variable acl

    Write-Output "Apply ACLs to child folders"

    #Set permissions on 2nd level folders 
    Get-ChildItem $JobFolderPath | Where-Object { $_.PSIsContainer } | ForEach-Object {
    
        Write-Output $_.FullName

        $acl2 = New-Object System.Security.AccessControl.DirectorySecurity
        $acl2.SetAccessRuleProtection($true,$false)
    
        $colRights = [System.Security.AccessControl.FileSystemRights]"Modify"
        $permission = "s CJVAdmin",$colRights,"ContainerInherit, ObjectInherit", ”None”,”Allow”
        $accessRule5 = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
        $acl2.AddAccessRule($accessRule5)


        $colRights = [System.Security.AccessControl.FileSystemRights]"FullControl"
        $permission = "s Domain Admins",$colRights,"ContainerInherit, ObjectInherit", ”None”,”Allow”
        $accessRule6 = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
        $acl2.AddAccessRule($accessRule6)
	
	
        $colRights = [System.Security.AccessControl.FileSystemRights]"Modify"
        $permission = "s KorteEmployees",$colRights,"ContainerInherit, ObjectInherit", ”None”,”Allow”
        $accessRule7 = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
        $acl2.AddAccessRule($accessRule7)


        Set-Acl $_.FullName $acl2
        Clear-Variable acl2
    }
    #Write-Output $_.FullName
    #break
##}