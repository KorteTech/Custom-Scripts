#Declare Servername
$sqlServer='TKCBT'
#Invoke-sqlcmd Connection string parameters
$params = @{'server'='TKCBT';'Database'='Loggly'}
 
import-module activedirectory



#get-module -listavailable

#Get-ADComputer -Filter *

$Rundate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Output $Rundate

Invoke-Sqlcmd @params -Query "DELETE FROM Loggly.dbo.ADComputersImport" 


#Load Computers
$complist = Get-ADComputer -Filter * -SearchBase "OU=ComputersMain, DC=korteco, DC=com"
foreach($Comp in $Complist) {
    Write-Output $Comp.Name
    $Computer = $Comp.Name
    # Data preparation for loading data into SQL table 
    $InsertResults = "INSERT INTO [Loggly].[dbo].[ADComputersImport](rundate, name) VALUES ('$Rundate','$Computer')"

    #call the invoke-sqlcmdlet to execute the query
    Invoke-sqlcmd @params -Query $InsertResults
}

 
  
Invoke-Sqlcmd @params -Query "SELECT  * FROM Loggly.dbo.ADComputersImport" | format-table -AutoSize