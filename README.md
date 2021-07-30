# Summary

The aim of this project is to build data pipelines pulling from various financial data sources. Sources are likely to be stock trading data and this data will be stored and modelled for analytics.

# Design

## Datalake

- Structure of the storage area will be separated into three areas
  - RAW: Landing/Staging area for initial dump of stock data from API
  - BASE: Target area for data. Data here is cleansed and transformed if necessary.
  - CONTROL: Holds data used as a part of the orchestration of the pipelines.

## Datafactory

- Ingestion
  - Use a single pipeline that reads from an API
  - Will need to set up a dataset for the source and reuse the target dataset
  - Use KeyVault for connection strings in dataset, API key

# Technology

This propject will be based around using Microsoft Azure resources, in particular:

- ARM Template
  - This is used to deploy resources. A Deploy_StartUp_Resource.json file will be used to create all start up resrouces such as key vault, storage and resource groups.
    - Tutorial to create an ARM template can be found [here] (<https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-create-first-template?tabs=azure-powershell>).
- Azure Data Factory
  - Orchestration and management of source data.
- Azure Key Vault
  - Storage of Keys and Secrets
- Azure Databricks
  - Delta Tables
    - Potential ML and other transformations
- Azure Data Lake Storage
- Power Shell
  - Used to initiate the deployment of certain resources.

# Data Sources

Below is a list of rsources for source data

- SimFin: <https://simfin.com/>
- Tiingo: <https://www.tiingo.com/>

# Set Up Notes

- Create Service Principle
  - Save principle secrte to key vault
- Datafactory Linked Services
  - Add service prinicple to access control IAM
    - Linked Service to KeyVault: Use service principle to authenticate
    - Linked Service to Source API: Use service principle to authenticate
- ADLS Storage
  - Manage access by adding service principle, ADF to access control
- Key Vault
  - Add access policies for service principle to ADLS
    - Add access policies for ADF. Will use service principle to authenticate and access sectrets
    - Add ADF to access control (IAM)
- Azure Databricks
  - Workspace deployed through ARM template
- .gitighnore
  - all parameter files (For now, will tidy this part up later)
