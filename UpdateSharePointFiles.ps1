# this script will go to the sharepoint repository, and download the list of files
# to the directory that you run it from, prepending the $versionPrefix onto them after it downloads them.
# then you can batch upload them to the sharepoint folder you need them in.


# $downloadPrefix = "http://3mem-sp01/Quality/ISO Documents/ENG. Engineering/"

$downloadPrefix = "https://attentiem.sharepoint.com/sites/usac.mmm/Quality/ISO Documents/ENG. Engineering/"


# put your prefix here, or none if you don't need anything
$versionPrefix = "Hardware Admin v1.64.0 - "

# put your list of files here.
$myFiles = @(
    "ENG-45 MRD Marketing Rqmt Doc.docx",
    "ENG-47 PRS Product Rqmt Specification.docx",
    "ENG-50 Arch-Func Design Review and Approval.docx",
    "ENG-52 Deployment Procedure.docx",
    "ENG-59 TRR Test Readiness Review.docx",
    "ENG-60 MRR Marketing Rqmt Review.docx",
    "ENG-61 Release Notes.docx",
    "ENG-64 PSR Product Rqmt Doc Review.docx",
    "ENG-71 ECR Eng Change Request.docx"
)

$userName = Read-Host "Enter your login ID"
$PasswordEncrypted = Read-Host -AsSecureString "Enter your password"

#$PasswordUnencrypted = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($PasswordEncrypted))
#$securePassword = $PasswordUnencrypted | ConvertTo-SecureString -asPlainText -Force

$credential = New-Object System.Management.Automation.PSCredential($userName,$PasswordEncrypted)   # $securePassword)

Foreach ($ArrayItem in $myFiles) {

    $DownloadPath = $DownloadPrefix + $ArrayItem
    Invoke-WebRequest -Uri $DownloadPath  -Outfile $ArrayItem -Credential $credential

    $newName = $versionPrefix + $ArrayItem
    Rename-Item $ArrayItem  $newName

}


