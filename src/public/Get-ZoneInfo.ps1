<#
.SYNOPSIS
Returns the "mark of the web" that stores the source details of a downloaded file.

.INPUTS
Any object with a Path or FullName property containing a System.String with a file path.

.OUTPUTS
System.Management.Automation.PSObject with the properties:
* ZoneName: The name of the security zone the file came from.
* ZoneId: The ID of the security zone the file came from.
* HostUrl: The URL the file was downloaded from.

.FUNCTIONALITY
Security

.EXAMPLE
Get-ZoneInfo.ps1 ~/Downloads/Git-2.55.0.5-64-bit.exe

File     : ~/Downloads/Git-2.55.0.5-64-bit.exe
ZoneName : Internet
ZoneId   : 3
HostUrl  : https://github.com/.../Git-2.55.0.5-64-bit.exe
#>

#Requires -Version 7.3
[CmdletBinding()][OutputType([pscustomobject])] Param(
# The file to return the ZoneIdentifier info for.
[Parameter(Position=0,Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
[Alias('FullName')][string] $Path
)
Begin
{
	$zoneName = @{
		0 = 'My Computer'
		1 = 'Local intranet'
		2 = 'Trusted sites'
		3 = 'Internet'
		4 = 'Restricted sites'
	}
}
Process
{
	if(!$IsWindows) {Write-Warning 'Not supported outside of Windows.'; return}
	$result = Get-Content $Path -Stream Zone.Identifier |
		Select-Object -Skip 1 |
		ConvertFrom-StringData
	$result['ZoneName'] = $zoneName[$_.ZoneId]
	return [pscustomobject]@{
		File     = $Path
		ZoneName = $zoneName[$result['ZoneId']]
		ZoneId   = $result['ZoneId']
		HostUrl  = $result['HostUrl']
	}
}
