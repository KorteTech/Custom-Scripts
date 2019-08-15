$dl=dir "E:\Accounting\TKC Employee Records" |?{$_.psiscontainer}
foreach ($d in $dl)
{
  if (test-path ("$($d.fullname)\HR"))
  {
    "Insert ACL command on main directory d.fullname"
    "found $($d.fullname)\HR"
    ##foreach ($f in (dir "$($d.fullname)\docs" -recurse))
    ##{
    ##  "working on $($f.fullname)"
    ##  "insert ACL command on file/dir f.fullname"      
    ##}
    
    $FolderPath = "$($d.fullname)\HR"
    ##$acl = Get-Acl $FolderPath    
    $acl = (Get-Item $FolderPath).GetAccessControl('Access')
    
    $colRights = [System.Security.AccessControl.FileSystemRights]"Modify" 
    $permission = "KCCHI_D\angieneske",$colRights,"ContainerInherit, ObjectInherit", ”None”,”Allow” 
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission  
    $acl.AddAccessRule($accessRule) 
    
    Set-Acl $FolderPath $acl
    Get-Acl $FolderPath | Format-List
  }
}