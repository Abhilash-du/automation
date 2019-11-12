'Description To convert the sheets of excels to csv files
'$Excel_Path
'$Output_Path

if WScript.Arguments.Count <> 2 then
    WScript.Echo "Out=Missing input Parameters"
	Wscript.echo "status=fail"
	WScript.Quit 1
end if


Excel_Path = WScript.Arguments(0)
Output_Path = WScript.Arguments(1)


Set oShell = WScript.CreateObject("WSCript.shell")

oShell.run "cmd /c rmdir Output_Path", 0, True
oShell.run "cmd /c mkdir Output_Path", 0, True


Set objFSO = CreateObject("Scripting.FileSystemObject")
strFile = objFSO.FileExists(Excel_Path)
	
If Not strFile Then
	WScript.Echo "out=excel doesn't exist, please check"
	Wscript.echo "status=fail"
	WScript.Quit 1
End If

	
Set objXls = CreateObject("Excel.Application")
Set objWBook = objXls.Workbooks.Open(Excel_Path)
objXls.DisplayAlerts = False

	
If Output_Path <> "" Then

	For Each Sheet In objWBook.Sheets
        Sheet.Copy
		objXls.ActiveWorkbook.SaveAs Output_Path & "\" & Sheet.Name & ".csv",6
		objXls.ActiveWorkbook.Close False
	Next 
End If

	objWBook.Close False
	objXls.Quit
	Set objWBook = Nothing
	Set objXls = Nothing

Wscript.echo "status=pass"
WScript.Quit 0
