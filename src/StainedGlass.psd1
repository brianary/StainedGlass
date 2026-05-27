# see https://docs.microsoft.com/powershell/scripting/developer/module/how-to-write-a-powershell-module-manifest
# and https://docs.microsoft.com/powershell/module/microsoft.powershell.core/new-modulemanifest
@{
RootModule = 'StainedGlass.psm1'
ModuleVersion = '0.0.0.0' # placeholder to be overridden
CompatiblePSEditions = @('Core')
GUID = '8e9b98c5-455f-4971-b87a-96dee89d9fff'
Author = 'Brian Lalonde'
CompanyName = 'Unknown'
Copyright = 'Copyright © 2026 Brian Lalonde'
Description = 'Utilities for Windows workstations and servers.'
PowerShellVersion = '7.0'
# RequiredModules = ,'Microsoft.PowerShell.Utility'
FunctionsToExport = @('*') # '*'
CmdletsToExport = @() # '*'
VariablesToExport = @() # '*'
# AliasesToExport = @()
FileList = @('StainedGlass.psd1','StainedGlass.psm1')
PrivateData = @{
	PSData = @{
		Tags = @('Windows','ActiveDirectory','ScheduledTasks','IIS','Terminal')
		LicenseUri = 'https://github.com/brianary/StainedGlass/blob/master/LICENSE'
		ProjectUri = 'https://github.com/brianary/StainedGlass/'
		IconUri = 'http://webcoder.info/images/StainedGlass.svg'
		# ReleaseNotes = ''
		# PS7: A list of external modules that this module is dependent upon.
		# ExternalModuleDependencies = ,'Microsoft.PowerShell.Utility'
	}
}
}
