<#
.SYNOPSIS
Tests finding modules used in projects.
#>

if(!(&"$PSScriptRoot/../scripts/Test-RelevantTest.ps1")) {return}
BeforeAll {
	Set-StrictMode -Version Latest
	&"$PSScriptRoot/../scripts/Import-ThisModule.ps1"
}
Describe 'Find-ProjectPackages' -Tag Find-ProjectPackages {
	Context 'Find modules used in projects' -Tag FindProjectPackages,Find,ProjectPackages {
		It "Finds an installed package" {
			Push-Location TestDrive:
			dotnet new console
			Find-ProjectPackages * |Should -BeNullOrEmpty
			dotnet add package Serilog
			$packages = dotnet list package --format json |ConvertFrom-Json
			$found = Find-ProjectPackages Serilog*
			$found.name |Should -BeExactly $packages.projects.frameworks.topLevelPackages.id
			Pop-Location
		}
	}

}
AfterAll {
	&"$PSScriptRoot/../scripts/Remove-ThisModule.ps1"
}
