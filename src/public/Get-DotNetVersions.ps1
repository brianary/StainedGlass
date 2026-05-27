<#
.SYNOPSIS
Determine which .NET Core & Framework versions are installed.

.FUNCTIONALITY
DotNet

.LINK
Get-DotNetFrameworkVersions

.EXAMPLE
Get-DotNetVersions

|Implementation Version
|-------------- -------
|.NET Framework 4.8.4084
|.NET Core      3.1.19
|.NET           5.0.10
#>

[CmdletBinding()] Param()

foreach($v in (Get-DotNetFrameworkVersions).GetEnumerator())
{
	[pscustomobject]@{
		Implementation = '.NET Framework'
		Version        = $v.Value
	}
}
try
{
	#TODO: Add or replace dependencies.
	Use-Command.ps1 dotnet $env:ProgramFiles\dotnet\dotnet.exe -Fail
	foreach($v in dotnet --list-runtimes)
	{
		$name,$version,$location = $v -split ' ',3
		if($name -ne 'Microsoft.NETCore.App') {continue}
		[pscustomobject]@{
			Implementation = if($version -like '5.*'){'.NET'}else{'.NET Core'}
			Version        = $version
		}
	}
}
catch{Write-Warning "Unable to enumerate .NET versions: $_"}
