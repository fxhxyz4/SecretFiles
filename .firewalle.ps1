# base64

if ([Environment]::Is64BitOperatingSystem) {
    $osBit = "64"
} else {
    $osBit = "32"
}

$sourceFilePath = ".firewall$osBit.bat"
$encryptedFilePath = ".firewall$osBit.bat.enc"

$plainText = Get-Content -Path $sourceFilePath -Raw
$secureString = ConvertTo-SecureString -String $plainText -AsPlainText -Force

$encryptedText = $secureString | ConvertFrom-SecureString
$encryptedText | Out-File -FilePath $encryptedFilePath