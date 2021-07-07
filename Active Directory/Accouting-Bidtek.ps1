$RootPath = Get-ChildItem -Directory -Path "\\tkcdata\Accounting"
ForEach ($RootFolder in $RootPath) {

$Output = @()
$Path = "\\tkcdata\Accounting\$RootFolder"
Write-Output $Path
}

$Acl = Get-Acl -Path $Path
ForEach ($Access in $Acl.Access) {
    $Properties = [ordered]@{'Folder Name'=$Path;'Group/User'=$Access.IdentityReference;'Permissions'=$Access.FileSystemRights;'Inherited'=$Access.IsInherited}
    $Output += New-Object -TypeName PSObject -Property $Properties            
}

$FolderPath = Get-ChildItem -Directory -Path $Path -Recurse -Force

ForEach ($Folder in $FolderPath) {
    $Acl = Get-Acl -Path $Folder.FullName
    ForEach ($Access in $Acl.Access) {
    #if (($Access.IdentityReference -ne "NT AUTHORITY\SYSTEM") -and ($Access.IdentityReference -ne "KCCHI_D\s Domain Admins") -and ($Access.IdentityReference -ne "KCCHI_D\s Accounting") `
    #    -and ($Access.IdentityReference -ne "KCCHI_D\sandyg")) {
    if ($Access.IsInherited -eq $False -and $Access.IdentityReference -ne "NT AUTHORITY\SYSTEM") {
        $Properties = [ordered]@{'Folder Name'=$Folder.FullName;'Group/User'=$Access.IdentityReference;'Permissions'=$Access.FileSystemRights;'Inherited'=$Access.IsInherited}
        $Output += New-Object -TypeName PSObject -Property $Properties            
        }
    }
}
$Output | Out-GridView -PassThru | Export-CSV -Path C:\Output\corporate.csv
#Get-Process | Out-GridView -PassThru | Export-CSV -Path C:\Output\Bowman.csv