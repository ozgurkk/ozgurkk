##### Environment Variables ###########
$env:vCenter
$env:Cluster
# Create a PSCredential Object using the "Username" and "Password" variables created on job
#$Password = $env:Password | ConvertTo-SecureString -AsPlainText -Force
#$creddentials = New-Object System.Management.Automation.PSCredential -ArgumentList #$env:UserName, $Password
########   Import module & Connect  ###########
Get-Module -Name VMware* -ListAvailable | Import-Module
Import-Module VMware.VimAutomation.Core
Add-PSSnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue
Connect-VIServer $env:vCenter -User user@vpshere.local -Password *********
#################################################################################
Invoke-Command {
get-cluster "$env:Cluster" | get-vm | Get-VIEvent | where {$_.FullFormattedMessage -match "vSphere HA restarted virtual machine"} | select ObjectName, CreatedTime, FullFormattedMessage | Format-Table -AutoSize

disconnect-VIServer $env:vCenter
}
