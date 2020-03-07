$VmResourceGroupName = "RG_WEU_CloudConnector" # Read-Host -Prompt "Enter the Resource Group name" #RG_WEU_CloudConnector
$location = "westeurope" # Read-Host -Prompt "Enter the location (i.e. centralus)"

$vmName = "az-ccc01"
$adminUsername = "azurelocaladmin" # Read-Host -Prompt "Enter the administrator username"
$adminPassword = Read-Host -Prompt "Enter the administrator password" -AsSecureString
$dnsLabelPrefix = "az-ccc01" # Read-Host -Prompt "Enter an unique DNS name for the public IP"

New-AzResourceGroup -Name $VmResourceGroupName -Location "$location"
New-AzResourceGroupDeployment `
    -Location 'westeurope' `
    -virtualMachineRG $VmResourceGroupName `
    -TemplateUri "https://raw.githubusercontent.com/xenblog/CVAD-AzurePoC/master/Templates/template.json" `
    -virtualMachineName $vmName `
    -adminUsername $adminUsername `
    -adminPassword $adminPassword `
    -subnetName 'Infrastructure' `
    -windowsOSVersion '2019-Datacenter' `
    -virtualMachineSize 'Standard_D2_v3'

 (Get-AzVm -ResourceGroupName $VmResourceGroupName).name
