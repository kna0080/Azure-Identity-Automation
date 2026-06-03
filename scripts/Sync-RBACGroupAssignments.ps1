<#
.SYNOPSIS
    Enforces Role-Based Access Control (RBAC) rules by syncing department groups.
#>
Import-Module Microsoft.Graph.Groups

$TargetDepartment = "Security"
$ExpectedGroupId = "00000000-0000-0000-0000-000000000000"

$Users = Get-MgUser -Filter "Department eq '$TargetDepartment'" -All

foreach ($User in $Users) {
    $CurrentGroups = Get-MgUserMemberOf -UserId $User.Id
    if ($CurrentGroups.Id -notcontains $ExpectedGroupId) {
        New-MgGroupMember -GroupId $ExpectedGroupId -DirectoryObjectId $User.Id
        Write-Host "Assigned RBAC alignment policy group to: $($User.UserPrincipalName)" -ForegroundColor Yellow
    }
}
