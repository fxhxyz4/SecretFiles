$plainText = Get-Content -Path "firewall64.bat"
$encryptedText = ConvertTo-SecureString -String $plainText -AsPlainText -Force
$encryptedText | Out-File -FilePath "firewall64.bat"