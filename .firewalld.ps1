if ([Environment]::Is64BitOperatingSystem) {
    $osBit = "64"
} else {
    $osBit = "32"
}

$encryptedFilePath = ".firewall$osBit.enc"
$decryptedFilePath = ".firewall$osBit.txt"

$encryptedText = Get-Content -Path $encryptedFilePath -Raw
$secureString = $encryptedText | ConvertTo-SecureString

$plainText = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureString)
)

$plainText | Out-File -FilePath $decryptedFilePath