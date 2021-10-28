##### Environment Variables ###########
# Note: Env. variables are used for jenkins pipeline to execute code. You may want to remove them to execute pure powershell code in powershell/powercli 
$vcservers = @("vc01.kolukisa.local","vc02.kolukisa.local","vc03.kolukisa.local")
$env:VM
#$env:SnapshotName
#$env:Musteri
#$env:Mailto
#$env:Subject
# Create a PSCredential Object using the "Username" and "Password" variables created on job
#$Password = $env:Password | ConvertTo-SecureString -AsPlainText -Force
#$creddentials = New-Object System.Management.Automation.PSCredential -ArgumentList #$env:UserName, $Password
############ Import Module & ConnectVI
Invoke-Command {
Get-Module -Name VMware* -ListAvailable | Import-Module
Import-Module VMware.VimAutomation.Core
Add-PSSnapin VMware.VimAutomation.Core -ErrorAction SilentlyContinue
Connect-VIServer $vcservers -User administrator@vsphere.local  -Password ********** -ErrorAction SilentlyContinue -Force
###### Master Code ################
# Establishing the connection to our vSphere object
$vm = Get-VM -Name $env:vm
$vmView = $vm | Get-View
# Creating a new PowerShell custom object to easily output properties
$output = New-Object -TypeName PSCustomObject
# Adding desired properties to the new PowerShell object
$diskCommit = $vmView.Storage.PerDatastoreUsage.Committed
$diskUncommit = $vmView.Storage.PerDatastoreUsage.Uncommitted
Add-Member -InputObject $output -MemberType NoteProperty -Name UsedSpaceGB -Value ($diskCommit / 1GB)
Add-Member -InputObject $output -MemberType NoteProperty -Name ProvisionedSpaceGB -Value (($diskCommit + $diskUncommit) / 1GB)
$diskKey = $vmView.LayoutEx.Disk.Key
$diskCapacity = $vmView.Config.Hardware.Device | Where-Object {$_.key -eq $diskKey} | Select-Object -ExpandProperty capacityInBytes
Add-Member -InputObject $output -MemberType NoteProperty -Name CapacityGB -Value ($diskCapacity / 1GB)
Add-Member -InputObject $output -MemberType NoteProperty -Name GuestPath -Value $vmView.Guest.Disk.DiskPath
Add-Member -InputObject $output -MemberType NoteProperty -Name GuestCapacityGB -Value ($vmView.Guest.Disk.Capacity / 1GB)
Add-Member -InputObject $output -MemberType NoteProperty -Name GuestFreeSpaceGB -Value ($vmView.Guest.Disk.FreeSpace / 1GB)
Write-Host "##### Your Quesry results shown below #####" -ForegroundColor red -BackgroundColor white
$output
}

########## Disconnect from vcenters  ##########
Disconnect-viserver $vcservers -Confirm:$False

