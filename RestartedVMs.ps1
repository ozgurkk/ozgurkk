##### Environment Variables ###########
## Script composed by Ozgur Kolukisa
## Purpose : This powercli script gives you a current list of vm's restarted by vSphere HA. Useful after an ESXi Host failure!
## mailto: ozgurkk@gmail.com
## Note: This script intended to use for Jenkins. To use in powershell, please comment environment variables below and add the reqiured variables directly.
#
$env:vCenter
$env:Cluster
# Create a PSCredential Object using the "Username" and "Password" variables created on job
#$Password = $env:Password | ConvertTo-SecureString -AsPlainText -Force
#$creddentials = New-Object System.Management.Automation.PSCredential -ArgumentList #$env:UserName, $Password
########   Import module & Connect  ###########
# You don't need to use Get-module/Import-Module and Add-pssnapin  cmdlets if you've already using powershell 7 and powercli => 10 together. If you've old versions of powershell and powercli, simply uncomment these rows.
#Get-Module -Name VMware* -ListAvailable | Import-Module
#Import-Module VMware.VimAutomation.Core
#Add-PSSnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue
Connect-VIServer $env:vCenter -User user@vpshere.local -Password *********
#################################################################################
#You need to  delete or uncomment line started with Invoke-Command  and the  last line char "}" , if you're not use this script in Jenkins.
Invoke-Command {
get-cluster "$env:Cluster" | get-vm | Get-VIEvent | where {$_.FullFormattedMessage -match "vSphere HA restarted virtual machine"} | select ObjectName, CreatedTime, FullFormattedMessage | Format-Table -AutoSize

disconnect-VIServer $env:vCenter
}
