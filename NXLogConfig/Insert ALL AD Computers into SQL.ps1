#Declare Servername
$sqlServer='TKCBT'
#Invoke-sqlcmd Connection string parameters
$params = @{'server'='TKCBT';'Database'='Loggly'}
 
import-module activedirectory



#get-module -listavailable

#Get-ADComputer -Filter *

$Rundate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Output $Rundate


# Load Servers
$vm1list = Get-ADComputer -Filter * -SearchBase "OU=Servers, DC=korteco, DC=com"
foreach($VM1 in $VM1list) {
    Write-Output $VM1.Name
    $Computer = $VM1.Name
    # Data preparation for loading data into SQL table 
    $InsertResults = "INSERT INTO [Loggly].[dbo].[ADComputersImport](rundate, name) VALUES ('$Rundate','$Computer')"

    #call the invoke-sqlcmdlet to execute the query
    Invoke-sqlcmd @params -Query $InsertResults
}

# Load Citrix Servers
$vm2list = Get-ADComputer -Filter * -SearchBase "OU=Citrix Servers, DC=korteco, DC=com"
foreach($VM2 in $VM2list) {
    Write-Output $VM2.Name
    $Computer = $VM2.Name
    # Data preparation for loading data into SQL table 
    $InsertResults = "INSERT INTO [Loggly].[dbo].[ADComputersImport](rundate, name) VALUES ('$Rundate','$Computer')"

    #call the invoke-sqlcmdlet to execute the query
    Invoke-sqlcmd @params -Query $InsertResults
}

# Load Conference Rooms
$vm3list = Get-ADComputer -Filter * -SearchBase "OU=Conference Rooms, DC=korteco, DC=com"
foreach($VM3 in $VM3list) {
    Write-Output $VM3.Name
    $Computer = $VM3.Name
    # Data preparation for loading data into SQL table 
    $InsertResults = "INSERT INTO [Loggly].[dbo].[ADComputersImport](rundate, name) VALUES ('$Rundate','$Computer')"

    #call the invoke-sqlcmdlet to execute the query
    Invoke-sqlcmd @params -Query $InsertResults
}

# Load Domain Controllers
$vm4list = Get-ADComputer -Filter * -SearchBase "OU=Domain Controllers, DC=korteco, DC=com"
foreach($VM4 in $VM4list) {
    Write-Output $VM4.Name
    $Computer = $VM4.Name
    # Data preparation for loading data into SQL table 
    $InsertResults = "INSERT INTO [Loggly].[dbo].[ADComputersImport](rundate, name) VALUES ('$Rundate','$Computer')"

    #call the invoke-sqlcmdlet to execute the query
    Invoke-sqlcmd @params -Query $InsertResults
}

#Load Computers
$complist = Get-ADComputer -Filter * -SearchBase "CN=Computers, DC=korteco, DC=com"
foreach($Comp in $Complist) {
    Write-Output $Comp.Name
    $Computer = $Comp.Name
    # Data preparation for loading data into SQL table 
    $InsertResults = "INSERT INTO [Loggly].[dbo].[ADComputersImport](rundate, name) VALUES ('$Rundate','$Computer')"

    #call the invoke-sqlcmdlet to execute the query
    Invoke-sqlcmd @params -Query $InsertResults
}

 
  
Invoke-Sqlcmd @params -Query "SELECT  * FROM Loggly.dbo.ADComputersImport" | format-table -AutoSize