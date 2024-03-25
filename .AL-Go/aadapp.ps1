Import-Module BcContainerHelper
$tenantId = 'ENTRA ID TENTANT ID'
$ClientId = 'ENTRA ID APP CLIENT ID'
$ClientIdSecret = 'ENTRA ID APP CLIENT SECRET'
#S2S-PTE
$AuthContext = New-BcAuthContext -clientID $ClientId -clientSecret $ClientIdSecret -tenantID $tenantId
Get-ALGoAuthContext -bcAuthContext $AuthContext | Set-Clipboard
#Impersonation-AppSource
$AuthContext = New-BcAuthContext -includeDeviceLogin -tenantID $tenantId
Get-ALGoAuthContext -bcAuthContext $AuthContext | Set-Clipboard
