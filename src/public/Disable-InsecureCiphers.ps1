<#
.SYNOPSIS
Disables insecure Windows TLS ciphers as flagged by ciphersuite.info.

.FUNCTIONALITY
Security

.LINK
https://ciphersuite.info/

.EXAMPLE
Disable-InsecureCiphers

Disables insecure TLS ciphers.
#>

[CmdletBinding(ConfirmImpact='High',SupportsShouldProcess=$true)] Param()
[string[]] $ciphers = @(TLS\Get-TlsCipherSuite).Name
Invoke-WebRequest https://ciphersuite.info/api/cs/security/insecure |
	Select-Object -ExpandProperty Content |
	ConvertFrom-Json -AsHashtable |
	ForEach-Object {$_.ciphersuites.Keys} |
	Where-Object {$_ -in $ciphers} |
	Where-Object {$PSCmdlet.ShouldProcess($_,'disable')} |
	ForEach-Object {TLS\Disable-TlsCipherSuite -Name $_}
