$location = "westeurope" # Read-Host -Prompt "Enter the location (i.e. centralus)"

$VmResourceGroupName = "RG_WEU_CloudConnector" # Read-Host -Prompt "Enter the Resource Group name" #RG_WEU_CloudConnector
$vmName = "az-ccc01"
$vmSize = "Standard_D2s_v3"
$adminUsername = "azurelocaladmin" # Read-Host -Prompt "Enter the administrator username"
$adminPassword = Read-Host -Prompt "Enter the administrator password" -AsSecureString

$NetworkResourceGroupName = "WEU-CoreService_rg"
$vNet = 'CoreNetwork'
$subnet = 'Infrastructure'

$ResourceId = (Get-AzResourceGroup -name $NetworkResourceGroupName ).ResourceId
$virtualNetworkId =  $ResourceId + "/providers/Microsoft.Network/virtualNetworks/" + $vNet
$nicName = $vmName + "_nic01"

#New-AzResourceGroup -Name $VmResourceGroupName -Location "$location"
#New-AzResourceGroupDeployment `
#    -ResourceGroupName $VmResourceGroupName `
#    -TemplateUri "https://raw.githubusercontent.com/xenblog/CVAD-AzurePoC/master/Templates/template.json" `
#    -virtualMachineName $vmName `
#    -adminUsername $adminUsername `
#    -adminPassword $adminPassword `
#    -subnetName 'Infrastructure' `
#    -windowsOSVersion '2019-Datacenter' `
#    -virtualMachineSize 'Standard_D2_v3'

New-AzResourceGroupDeployment `
    -ResourceGroupName $VmResourceGroupName `
    -TemplateFile .\Templates\template.json `
    -location $location `
    -networkInterfaceName $nicName `
    -virtualMachineName $vmName `
    -virtualMachineRG $VmResourceGroupName `
    -windowsOSVersion "2019-Datacenter" `
    -virtualMachineSize $vmSize `
    -subnetName $subnet `
    -virtualNetworkId $virtualNetworkId `
    -adminUsername $adminUsername `
    -adminPassword $adminPassword 
    
    (Get-AzVm -ResourceGroupName $VmResourceGroupName).name
