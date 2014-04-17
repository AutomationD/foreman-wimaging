 - similar to wget but written in vbscript
'based on a script by Chrissy LeMaire
 
' Usage
if WScript.Arguments.Count < 1 then
  MsgBox "Usage: wget.vbs <url> (file)"
  WScript.Quit
end if
 
' Arguments
URL = WScript.Arguments(0)
if WScript.Arguments.Count > 1 then
  saveTo = WScript.Arguments(1)
else
  parts = split(url,"/") 
  saveTo = parts(ubound(parts))
end if
 
' Fetch the file
Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP")
 
objXMLHTTP.open "GET", URL, false
objXMLHTTP.send()
 
If objXMLHTTP.Status = 200 Then
Set objADOStream = CreateObject("ADODB.Stream")
objADOStream.Open
objADOStream.Type = 1 'adTypeBinary
 
objADOStream.Write objXMLHTTP.ResponseBody
objADOStream.Position = 0    'Set the stream position to the start
 
Set objFSO = Createobject("Scripting.FileSystemObject")
If objFSO.Fileexists(saveTo) Then objFSO.DeleteFile saveTo
Set objFSO = Nothing
 
objADOStream.SaveToFile saveTo
objADOStream.Close
Set objADOStream = Nothing
End if
 
Set objXMLHTTP = Nothing
 
' Done
WScript.Quit
