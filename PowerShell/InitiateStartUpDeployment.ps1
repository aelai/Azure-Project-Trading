
#Authenticate azure account
Connect-AzAccount

#Check if resource group already exists
Get-AzResourceGroup -Name rgAzureProject -ErrorVariable notPresent -ErrorAction SilentlyContinue
if ($notPresent) {
    Write-Host "Creating new resource group"
    New-AzResourceGroup `
        -Name rgAzureProject `
        -Location "Central US"
}
else {
    Write-Host "Resource group rgAzureProject already exists."
}

Get-AzStorageAccount -ResourceGroupName rgAzureProject -Name adlsazureproject2020 -ErrorVariable noStorage
if ($noStorage) {  
    Write-Host "Creating Storage Account adlsazureproject2020"
    
    #Deploy ARM template for storage
    New-AzResourceGroupDeployment `
        -Name Deploy_StartUp_StorageAccount `
        -ResourceGroupName rgAzureProject `
        -TemplateFile "ARM Template/Deploy_StartUp_StorageAccount.json"
}
else {
    Write-Host "Resource group adlsazureproject2020 already exists."
}

Get-AzKeyVault -VaultName kvazureproject -ErrorVariable noKeyVault -ErrorAction SilentlyContinue
if ($noKeyVault){
#if ([string]::IsNullOrEmpty($noKeyVault)) {  
    Write-Host "Creating Key Vault"
    #Deploy ARM template for key vault
    New-AzResourceGroupDeployment `
        -Name Deploy_StartUp_KeyVault `
        -ResourceGroupName rgAzureProject `
        -TemplateFile "ARM Template/Deploy_StartUp_KeyVault.json"`
        -TemplateParameterFile "ARM Template/AzureProjectKeyVaultParameters.json"

}
else {
    Write-Host "Key Vault already exists."
}

Get-AzDataFactoryV2 -ResourceGroupName rgAzureProject -ErrorVariable noADF -ErrorAction SilentlyContinue
if ($noADF)
{ #if ([string]::IsNullOrEmpty($noADF))  
    Write-Host "Creating Azure DataFactory"
    #Deploy ARM template for key vault
    New-AzResourceGroupDeployment `
        -Name Deploy_StartUp_AzureDataFactory `
        -ResourceGroupName rgAzureProject `
        -TemplateFile "ARM Template/Deploy_StartUp_ADFv2.json"`
        -TemplateParameterFile "ARM Template/AzureProjectADFParameters.json"

}
else {
    Write-Host "Azure DataFactory already exists."
}

Get-AzDatabricksWorkspace -ResourceGroupName rgAzureProject -ErrorVariable noDBW -ErrorAction SilentlyContinue
if ($noDBW) {
    Write-Host "Creating Databricks Workspace"
    #Deploy ARM template for databricks workspace
    New-AzResourceGroupDeployment `
        -Name Deploy_StartUp_DatabricksWorkspace `
        -ResourceGroupName rgAzureProject `
        -TemplateFile "ARM Template/Deploy_StartUp_DatabricksWorkspace.json"`
        -TemplateParameterFile "ARM Template/AzureProjectDatabricksParameters.json"
}
else {
    Write-Host "Databricks Workspace already exists."
}
