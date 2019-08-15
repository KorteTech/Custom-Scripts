Dim Shell, lnk, newName, strIdx, FSO

Set Shell = CreateObject("WScript.Shell")

on error resume next
Set FSO = CreateObject("Scripting.FileSystemObject")
                  
FSO.DeleteFolder("\\rackstation\ArchivesByJobNumber\ClosedProjects")
FSO.DeleteFolder("\\rackstation\ArchivesByJobNumber\LostProjects")

FSO.CreateFolder("\\rackstation\ArchivesByJobNumber\ClosedProjects")
FSO.CreateFolder("\\rackstation\ArchivesByJobNumber\LostProjects")


ShowSubfolders FSO.GetFolder("\\rackstation\ClosedProjects"), 1, "\\rackstation\ArchivesByJobNumber\ClosedProjects\"
ShowSubfolders FSO.GetFolder("\\rackstation\LostProjects"), 1, "\\rackstation\ArchivesByJobNumber\LostProjects\"

Sub ShowSubFolders(Folder, Depth, Target)
    If Depth > 0 then
        For Each Subfolder in Folder.SubFolders
	    if Subfolder.name <> "#recycle" then
		'strIdx = InStrRev(Subfolder.name,"_",-1)		
		strIdx = Len(Subfolder.name) - 5		
		if len(Subfolder.name) > 5 then
		  if len(mid(Subfolder.name,strIdx+1, len(Subfolder.name)-strIdx)) <= 5 _
			and len(mid(Subfolder.name,strIdx+1, len(Subfolder.name)-strIdx)) > 0 _			
			and IsNumeric(mid(Subfolder.name,strIdx+1, len(Subfolder.name)-strIdx)) then
			newName = mid(Subfolder.name,strIdx+1, len(Subfolder.name)-strIdx) + "_" + Left(Subfolder.name,strIdx-1)
		  else
		  	newName = Subfolder.name
		  end if
		else
			newName = Subfolder.name
		end if		
		
		'wscript.echo "Saving Shortcut " + newName		
		Set lnk = Shell.CreateShortcut(Target + newName + ".lnk")			
		lnk.TargetPath = Subfolder.Path
		lnk.Save		   	        
		ShowSubFolders Subfolder, Depth -1, Target
	    end if
        Next
    End if
End Sub