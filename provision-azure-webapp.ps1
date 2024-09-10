param (
    [string]$resourceGroupName,
    [string]$appServicePlanName,
    [string]$webAppName,
    [string]$location
)

# Login to Azure
Connect-AzAccount -Identity

# Create Resource Group
if (-not (Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $resourceGroupName -Location $location
}

# Create App Service Plan
if (-not (Get-AzAppServicePlan -ResourceGroupName $resourceGroupName -Name $appServicePlanName -ErrorAction SilentlyContinue)) {
    New-AzAppServicePlan -Name $appServicePlanName -ResourceGroupName $resourceGroupName -Location $location -Tier Standard -NumberOfWorkers 1
}

# Create Web App
if (-not (Get-AzWebApp -ResourceGroupName $resourceGroupName -Name $webAppName -ErrorAction SilentlyContinue)) {
    New-AzWebApp -Name $webAppName -ResourceGroupName $resourceGroupName -Location $location -AppServicePlan $appServicePlanName
}
