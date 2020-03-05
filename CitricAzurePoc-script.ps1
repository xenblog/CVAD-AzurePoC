$VmResourceGroupName = "RG_WEU_CloudConnector" # Read-Host -Prompt "Enter the Resource Group name" #RG_WEU_CloudConnector
$location = "westeurope" # Read-Host -Prompt "Enter the location (i.e. centralus)"
$adminUsername = "azurelocaladmin" # Read-Host -Prompt "Enter the administrator username"
$adminPassword = Read-Host -Prompt "Enter the administrator password" -AsSecureString
$dnsLabelPrefix = "az-ccc01" # Read-Host -Prompt "Enter an unique DNS name for the public IP"

New-AzResourceGroup -Name $VmResourceGroupName -Location "$location"
New-AzResourceGroupDeployment `
    -ResourceGroupName $VmResourceGroupName `
    -TemplateUri "https://raw.githubusercontent.com/xenblog/CVAD-AzurePoC/master/Templates/CitrixCloudConnector.json" `
    -vmName "az-ccc01" `
    -adminUsername $adminUsername `
    -adminPassword $adminPassword `
    -dnsLabelPrefix $dnsLabelPrefix `
    -windowsOSVersion '2019-Datacenter' `
    -vmSize 'Standard_D2_v3'

 (Get-AzVm -ResourceGroupName $VmResourceGroupName).name
