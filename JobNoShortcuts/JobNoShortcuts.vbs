Dim Shell, lnk, newName, strIdx, FSO

Set Shell = CreateObject("WScript.Shell")


on error resume next
Set FSO = CreateObject("Scripting.FileSystemObject")
FSO.DeleteFolder("\\tkccloud\cloudjobview\Illinois_JobNo")
FSO.DeleteFolder("\\tkccloud\cloudjobview\Missouri_JobNo")
FSO.DeleteFolder("\\tkccloud\cloudjobview\National_JobNo")
FSO.DeleteFolder("\\tkccloud\cloudjobview\Oklahoma_JobNo")

FSO.CreateFolder("\\tkccloud\cloudjobview\Illinois_JobNo")
FSO.CreateFolder("\\tkccloud\cloudjobview\Missouri_JobNo")
FSO.CreateFolder("\\tkccloud\cloudjobview\National_JobNo")
FSO.CreateFolder("\\tkccloud\cloudjobview\Oklahoma_JobNo")


ShowSubfolders FSO.GetFolder("\\tkccloud\cloudjobview\Illinois"), 1
ShowSubfolders FSO.GetFolder("\\tkccloud\cloudjobview\Missouri"), 1
ShowSubfolders FSO.GetFolder("\\tkccloud\cloudjobview\National"), 1
ShowSubfolders FSO.GetFolder("\\tkccloud\cloudjobview\Oklahoma"), 1


Sub ShowSubFolders(Folder, Depth)
    If Depth > 0 then
        For Each Subfolder in Folder.SubFolders
		strIdx = InStrRev(Subfolder.name,"_",-1)
		if strIdx > 5 then
		  if len(mid(Subfolder.name,strIdx+1, len(Subfolder.name)-strIdx)) <= 5 then
			newName = mid(Subfolder.name,strIdx+1, len(Subfolder.name)-strIdx) + "_" + Left(Subfolder.name,strIdx-1)
		  elseif len(mid(Subfolder.name,strIdx+1, len(Subfolder.name)-strIdx)) = 11 then
			newName = mid(Subfolder.name,strIdx+1, len(Subfolder.name)-strIdx) + "_" + Left(Subfolder.name,strIdx-1)
		  end if
		
			'wscript.echo newName
			wscript.echo "\\tkccloud\cloudjobview\" + Folder.name + "_JobNo\" + newName
			Set lnk = Shell.CreateShortcut("\\tkccloud\cloudjobview\" + Folder.name + "_JobNo\" + newName + ".lnk")
			lnk.TargetPath = Subfolder.Path
			lnk.Save            
		end if
        
	    ShowSubFolders Subfolder, Depth -1 
        Next
    End if
End Sub


'Set lnk = Shell.CreateShortcut("c:\target.lnk")

'lnk.TargetPath = "C:\Users\barrykauhl.KCCHI_D\Documents"

'lnk.Save
