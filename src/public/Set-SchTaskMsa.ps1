<#
.SYNOPSIS
Sets a Scheduled Task's runtime user as the given gMSA/MSA.

.FUNCTIONALITY
Scheduled Tasks

.INPUTS
An object with a TaskName string property.

.LINK
https://learn.microsoft.com/windows-server/identity/ad-ds/manage/group-managed-service-accounts/group-managed-service-accounts/group-managed-service-accounts-overview

.LINK
Set-ScheduledTask

.LINK
New-ScheduledTaskPrincipal

.EXAMPLE
Set-SchTaskMsa 'Backup VSCode settings' automation

Sets the tasks running user to the "automation" managed service account.
#>

[CmdletBinding()] Param(
# The name of the task to update.
[Parameter(Position=0,Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string] $TaskName,
# The account to run the task as.
[Parameter(Position=1,Mandatory=$true)][Alias('MSA','gMSA','UserId')][string] $ServiceAccount,
# Whether the task should be run with elevated permissions.
[switch] $HighestRunLevel
)
Process
{
    Set-ScheduledTask -TaskName $TaskName -Principal (New-ScheduledTaskPrincipal -UserID $ServiceAccount `
        -LogonType Password -RunLevel:($HighestRunLevel ? 'Highest' : 'Normal'))
}
