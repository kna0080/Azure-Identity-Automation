<#
.SYNOPSIS
    Automates enterprise user provisioning into Entra ID using Microsoft Graph.
#>
Import-Module Microsoft.Graph.Users

$PasswordProfile = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphPasswordProfile
$PasswordProfile.Password = "TempPass123!#ChangeMe"
$PasswordProfile.ForceChangePasswordNextSignIn = $true

$UserParams = @{
    AccountEnabled    = $true
    DisplayName       = "John Doe"
    MailNickname      = "jdoe"
    UserPrincipalName = "jdoe@yourdomain.onmicrosoft.com"
    PasswordProfile   = $PasswordProfile
}

New-MgUser @UserParams
Write-Host "Successfully provisioned identity user context." -ForegroundColor Green
