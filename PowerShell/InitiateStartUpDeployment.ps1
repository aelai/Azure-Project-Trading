[CmdletBinding()]
param (
    $SubscriptionID,
    $SubscriptionName,
    $Tenant
)
Connect-AzAccount

Set-AzContext [ $SubscriptionID/$SubscriptionName/$Tenant]
