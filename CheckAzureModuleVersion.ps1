Get-Module -Name Az -ListAvailable
# list all available versions of the Az module that are installed on your system.

# Get-Module: This is a PowerShell cmdlet that retrieves the status of modules in your PowerShell environment.
# -Name Az: This parameter specifies that you want information about the Az module. Az is the Azure PowerShell module.
# -ListAvailable: This parameter tells PowerShell to list all versions of the specified module that are installed on your system, not just the ones that are currently imported or loaded into the session.

Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force -AllowClobber
#  When this code is executed, it will install the "Az" module from the "PSGallery" repository, specifically for the current user. Run if you have no Modules installed. 
