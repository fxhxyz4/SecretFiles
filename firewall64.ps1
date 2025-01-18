$plainText = Get-Content -Path "firewall64.bat"
$encryptedText = ConvertTo-SecureString -String $plainText -AsPlainText -Force

$encryptedText | Out-File -FilePath "firewall64.bat"

$acl = Get-Acl -Path "firewall64.bat"
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrators", "FullControl", "Allow")

$acl.SetAccessRule($rule)
Set-Acl -Path "firewall64.bat" -AclObject $acl