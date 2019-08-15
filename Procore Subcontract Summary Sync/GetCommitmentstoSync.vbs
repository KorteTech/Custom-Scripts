Set Shell = CreateObject("WScript.Shell")
Set FSO = CreateObject("Scripting.FileSystemObject")
Dim Shell, lnk, searchFolder, strIdx, FSO

Set objConn = CreateObject("ADODB.connection")
Set objCmd = CreateObject("ADODB.Command")

objConn.ConnectionString = "Provider=sqloledb;Data Source=tkcbt;Initial Catalog=Procore; User Id=intranet;Password=popzombie;"
objConn.Open

With objCmd
 Set .ActiveConnection = objConn
 .CommandText = "{call AddFilesToSync(?,?,?,?)}"
 .Parameters.Append .CreateParameter("FullPath", 200, 1, 500)
 .Parameters.Append .CreateParameter("Job", 200, 1, 20)
 .Parameters.Append .CreateParameter("Filename", 200, 1, 255)
 .Parameters.Append .CreateParameter("LastModifiedDate", 135,1) 
End With

	'on error resume next


	ShowSubfolders FSO.GetFolder("\\tkccloud\cloudjobview\Illinois"), 1
	ShowSubfolders FSO.GetFolder("\\tkccloud\cloudjobview\Missouri"), 1
	ShowSubfolders FSO.GetFolder("\\tkccloud\cloudjobview\National"), 1
	ShowSubfolders FSO.GetFolder("\\tkccloud\cloudjobview\Oklahoma"), 1
	
	'Cleanup
	objConn.Close
	Set objConn = Nothing
	Set objCmd = Nothing
	Set objFolder = Nothing
	Set colFiles = Nothing
	Set FSO = Nothing
	
Sub ShowSubFolders(Folder, Depth)
    If Depth > 0 then
	'list of each job subfolder
        For Each Subfolder in Folder.SubFolders
			startPos = InStrRev(Subfolder.name,"_")
			job = Mid(Subfolder.name,startPos + 1,Len(Subfolder.name) - StartPos + 1)			
			searchFolder = Folder + "\" + Subfolder.name + "\Contracts_&_POs\Subcontracts\_SubcontractSummary"						
			
			if FSO.FolderExists(searchFolder) then
				Set objFolder = FSO.GetFolder(searchFolder)
				wscript.echo "found"
				For Each File in objFolder.Files
				'TODO Only grab files modofied recently
					'wscript.echo searchFolder			
					'wscript.echo job
					wscript.echo File.name
					'wscript.echo  File.DateLastModified
					    objCmd.Parameters("FullPath") = searchFolder
						objCmd.Parameters("Job") = job
						objCmd.Parameters("Filename") = File.Name
						objCmd.Parameters("LastModifiedDate") = File.DateLastModified
						objCmd.Execute					
				Next
			End if
			
			ShowSubFolders Subfolder, Depth -1 
        Next
    End if
		
End Sub


'Set lnk = Shell.CreateShortcut("c:\target.lnk")

'lnk.TargetPath = "C:\Users\barrykauhl.KCCHI_D\Documents"
'\\tkccloud\cloudjobview\Missouri\BJC Missouri Baptist Addition St. Louis_70673\Contracts_&_POs\Subcontracts\_SubcontractSummary
'N:\Missouri\BJC West County MOB Creve Coeur_70678\Contracts_&_POs\Subcontracts\_SubcontractSummary
'lnk.Save
