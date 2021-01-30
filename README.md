# Summary
The aim of this project is to build data pipelines pulling from various financial data sources. Sources are likely to be stock trading data and this data will be stored and modelled for analytics.

# Technology
This propject will be based around using Microsoft Azure resources, in particular:
- ARM Template
    - This is used to deploy resources. A Deploy_StartUp_Resource.json file will be used to create all start up resrouces such as key vault, storage and resource groups.
    - Tutorial to create an ARM template can be found [here] (https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-create-first-template?tabs=azure-powershell).
- Azure Data Factory
    - Orchestration and management of source data.
- Azure Data Lake Storage
- Power Shell
    - Used to initiate the deployment of certain resources.

# Data Sources
Below is a list of rsources for source data
- SimFin: https://simfin.com/

# Set Up Notes
- Create Service Principle
    - Save principle secrte to key vault
- Datafactory Linked Services
    - Add service prinicple to access control IAM
    - Linked Service to KeyVault: Use service principle to authenticate
    - Linked Service to Source API: Use service principle to authenticate
- ADLS Storage
    - Managed access by adding service principle
- Key Vault
    - Add access policies for service principle to ADLS
    - Add access policies for ADF. Will use service principle to authenticate and access sectrets
    - Add ADF to access control (IAM)


