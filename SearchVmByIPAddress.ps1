##### Environment Variables ###########
$vcservers = @("vc01.kolukisa.local","vc02.kolukisa.local")
$env:IP
# Create a PSCredential Object using the "Username" and "Password" variables created on job
#$Password = $env:Password | ConvertTo-SecureString -AsPlainText -Force
#$creddentials = New-Object System.Management.Automation.PSCredential -ArgumentList #$env:UserName, $Password
############ Import Module & ConnectVI
Invoke-Command {
Get-Module -Name VMware* -ListAvailable | Import-Module
Import-Module VMware.VimAutomation.Core
Add-PSSnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue
Connect-VIServer $vcservers -User user@vpshere.local  -Password ******** -ErrorAction SilentlyContinue -Force
###### Master Code ################
Get-VM * | where-object{$_.Guest.IPAddress -match "$env:IP"} | % {
[PSCustomObject] @{
Name = $_.Name
IPAddress = $_.Guest.IPAddress
Guest = $_.Guest
Host = $_.VMhost
Cluster = $_.VMHost.Parent
vCenter = $_.Uid.Substring($_.Uid.IndexOf('@')+1).Split(":")[0]
}
} | format-table -Wrap
}
########## Disconnect from vcenters  ##########
Disconnect-viserver $vcservers -Confirm:$False

