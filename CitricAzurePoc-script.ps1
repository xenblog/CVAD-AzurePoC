$VmResourceGroupName = Read-Host -Prompt "Enter the Resource Group name" #RG_WEU_CloudConnector
$NetworkResourceGroupName = Read-Host -Prompt "Enter the Resource Group name"
$location = Read-Host -Prompt "Enter the location (i.e. centralus)"
$adminUsername = Read-Host -Prompt "Enter the administrator username"
$adminPassword = Read-Host -Prompt "Enter the administrator password" -AsSecureString
$dnsLabelPrefix = Read-Host -Prompt "Enter an unique DNS name for the public IP"

New-AzResourceGroup -Name $VmResourceGroupName -Location "$location"
New-AzResourceGroupDeployment `
    -ResourceGroupName $VmResourceGroupName `
    -TemplateUri "https://raw.githubusercontent.com/xenblog/CVAD-AzurePoC/master/Templates/CitrixCloudConnector.json" `
    -vmName "az-ccc01" `
    -adminUsername $adminUsername `
    -adminPassword $adminPassword `
    -dnsLabelPrefix $dnsLabelPrefix `
    -windowsOSVersion '2012-R2-Datacenter' `
    -vmSize 'Standard_D2_v3'

 (Get-AzVm -ResourceGroupName $VmResourceGroupName).name
