<#
.SYNOPSIS
Tests formattting a datetime as a LogParser literal.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'ConvertTo-LogParserTimestamp' -Tag ConvertTo-LogParserTimestamp -Skip:$skip {
	Context 'Formats a datetime as a LogParser literal' `
		-Tag ConvertToLogParserTimestamp,Convert,ConvertTo,LogParserTimestamp,LogParser {
		It "Converts '<DateTime>' into a LogParser timestamp expression" -TestCases @(
			@{ DateTime = (Get-Date) }
			@{ DateTime = '2000-01-01' }
			@{ DateTime = '2002-02-20 02:20:02' }
			@{ DateTime = '2022-02-22 22:20:20' }
			@{ DateTime =  (Get-Date '1970-01-01Z').AddSeconds((Get-Random)) }
			@{ DateTime =  (Get-Date '1970-01-01Z').AddSeconds((Get-Random)) }
			@{ DateTime =  (Get-Date '1970-01-01Z').AddSeconds((Get-Random)) }
			@{ DateTime =  (Get-Date '1970-01-01Z').AddSeconds((Get-Random)) }
			@{ DateTime =  (Get-Date '1970-01-01Z').AddSeconds((Get-Random)) }
		) {
			Param([datetime] $DateTime)
			$DateTime |
				ConvertTo-LogParserTimestamp |
				Should -BeExactly "timestamp('$(Get-Date $DateTime -f 'yyyy-MM-dd HH:mm:ss')','yyyy-MM-dd HH:mm:ss')" `
				-Because 'pipeline should work'
			ConvertTo-LogParserTimestamp $DateTime |
				Should -BeExactly "timestamp('$(Get-Date $DateTime -f 'yyyy-MM-dd HH:mm:ss')','yyyy-MM-dd HH:mm:ss')" `
				-Because 'parameter should work'
		}
	}
}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
