
Dim Shell, lnk, newName, strIdx, FSO

Set Shell = CreateObject("WScript.Shell")


'on error resume next
Set FSO = CreateObject("Scripting.FileSystemObject")





ShowSubfolders FSO.GetFolder("\\tkccloud\PreviousVersions\Local\Dec 30 2016 00.00.00\CloudJobView\National"), 1


Sub ShowSubFolders(Folder, Depth)
    If Depth > 0 then
        For Each Subfolder in Folder.SubFolders
		strIdx = InStrRev(Subfolder.name,"_",-1)

		'if len(mid(Subfolder.name,strIdx+1, len(Subfolder.name)-strIdx)) <= 5 then
		'	newName = mid(Subfolder.name,strIdx+1, len(Subfolder.name)-strIdx) + "_" + Left(Subfolder.name,strIdx-1)
		'else
			newName = "\\tkccloud\cloudjobview\National\" + Subfolder.name
		'end if
		
			wscript.echo newName
			if  FSO.FolderExists(newName) then
			wscript.echo "exists"
			else
			wscript.echo newName
			FSO.CreateFolder(newName)
          
			end if
        
	    ShowSubFolders Subfolder, Depth -1 
        Next
    End if
End Sub


'Set lnk = Shell.CreateShortcut("c:\target.lnk")

'lnk.TargetPath = "C:\Users\barrykauhl.KCCHI_D\Documents"

'lnk.Save
