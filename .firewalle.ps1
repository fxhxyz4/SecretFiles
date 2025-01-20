# base64
# todo with AES

if ([Environment]::Is64BitOperatingSystem) {
    $osBit = "64"
} else {
    $osBit = "32"
}

$sourceFilePath = ".firewall$osBit.txt"
$encryptedFilePath = ".firewall$osBit.enc"

$plainText = Get-Content -Path $sourceFilePath -Raw
$secureString = ConvertTo-SecureString -String $plainText -AsPlainText -Force

$encryptedText = $secureString | ConvertFrom-SecureString
$encryptedText | Out-File -FilePath $encryptedFilePath