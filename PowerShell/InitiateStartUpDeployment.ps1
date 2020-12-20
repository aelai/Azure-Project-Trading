[CmdletBinding()]
param (
    $FilePathStorage,
    $FilePathKeyVault
)
#Authenticate azure account
Connect-AzAccount

#Check if resource group already exists
Get-AzResourceGroup -Name rgAzureProject -ErrorVariable notPresent -ErrorAction SilentlyContinue
if ($notPresent)
{
    Write-Host "Creating new resource group"
    New-AzResourceGroup `
    -Name rgAzureProject `
    -Location "Central US"
}
else
{
    Write-Host "Resource group rgAzureProject already exists."
}

Get-AzStorageAccount -Name adlsazureproject2020 -ErrorVariable notPresent -ErrorAction SilentlyContinue
if ($notPresent)
{  
    Write-Host "Creating Storage Account adlsazureproject2020"
    
    #Deploy ARM template for storage
    New-AzResourceGroupDeployment `
    -Name Deploy_StartUp_StorageAccount `
    -ResourceGroupName rgAzureProject `
    -TemplateFile $FilePathStorage
}
else
{
    Write-Host "Resource group adlsazureproject2020 already exists."
}

Get-AzKeyVault -Name kvazureproject -ErrorVariable notPresent -ErrorAction SilentlyContinue
if ($notPresent)
{  
    Write-Host "Creating Key Vault"
    #Deploy ARM template for key vault
    New-AzResourceGroupDeployment `
    -Name Deploy_StartUp_KeyVault `
    -ResourceGroupName rgAzureProject `
    -TemplateFile $FilePathKeyVault

}
else
{
    Write-Host "Key Vault already exists."
}