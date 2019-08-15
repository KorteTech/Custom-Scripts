Dim objFSO, objFolder, colFiles, objFile, objConn, objCmd, strSourcePath, strTargetPath

Main

Sub Main()

Dim co, mth, trans, month, year, f

Set objFSO = CreateObject("Scripting.FileSystemObject")

Set objConn = CreateObject("ADODB.connection")
Set objCmd = CreateObject("ADODB.Command")

objConn.ConnectionString = "Provider=sqloledb;Data Source=tkcbt;Initial Catalog=Viewpoint; User Id=intranet;Password=popzombie;"
objConn.Open

With objCmd
 Set .ActiveConnection = objConn
 .CommandText = "{? = call tkcCreateImageEntry(?,?,?,?)}"
 .Parameters.Append .CreateParameter("retval", 2, 4, 0)
 .Parameters.Append .CreateParameter("co", 2, 1)
 .Parameters.Append .CreateParameter("mth", 133, 1)
 .Parameters.Append .CreateParameter("trans", 3, 1)
 .Parameters.Append .CreateParameter("filepath", 200, 1, 255)

End With
 
 



Set objFolder = objFSO.GetFolder("C:\PDF Files")
Set colFiles = objFolder.Files
For Each objFile In colFiles
    

    co = Mid(objFile.Name, 3, 2)
    mth = Mid(objFile.Name, 5, 6)
    trans = Mid(objFile.Name, 11, 5)
    month = MonthName(Mid(mth, 1, 2))
    year= 2000 + cint(Mid(mth, 5, 2))

    mth = Mid(mth, 1, 2) + "/" + Mid(mth, 3, 2) + "/" + Mid(mth, 5, 2)
        
    strSourcePath = "C:\PDF Files"
    strTargetPath = "\\tkcdata\APImages\" + cstr(year) + "\" + cstr(month) + "\"

    objCmd.Parameters("co") = co
    objCmd.Parameters("mth") = CDate(mth)
    objCmd.Parameters("trans") = trans
    objCmd.Parameters("filepath") = strTargetPath + objFile.Name

    'Make sure target folder exists, otherwise create it
    If Not objFSO.FolderExists(strTargetPath) Then
        BuildFullPath (strTargetPath)
    End if

    'move file to tkcdata
    wscript.echo "moving " + strSourcePath + "\" + objFile.Name + " to " + strTargetPath

    If objFSO.FileExists(strTargetPath + "\" + objFile.Name) Then
        objFSO.DeleteFile  strTargetPath + "\" + objFile.Name
    End if

    objFSO.MoveFile strSourcePath + "\" + objFile.Name, strTargetPath
    
    'wscript.echo "updating Viewpoint CO:" + cstr(co) + " mth:" + cstr(CDate(mth)) + " trans:" + cstr(trans) + " path:" + objCmd.Parameters("filepath")
    'Call the stored proc
    objCmd.Execute
Next

objConn.Close

Set objConn = Nothing
Set objCmd = Nothing
Set objFolder = Nothing
Set colFiles = Nothing
Set objFSO = Nothing

End Sub


Sub BuildFullPath(ByVal FullPath)
'wscript.echo FullPath
    If Not objFSO.FolderExists(FullPath) Then
        BuildFullPath objFSO.GetParentFolderName(FullPath)
        objFSO.CreateFolder FullPath
    End If
End Sub
