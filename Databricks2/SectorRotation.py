# Databricks notebook source
# import libraries

from pyspark.sql.functions import substring, concat, col, lit
import pandas as pd
import numpy as np

# COMMAND ----------

# Set storage account keys

storage_account_name = "adlsazureproject2020"
storage_account_access_key = "f7EcZqfPavKzLW0Yv2wOiaFfVre3mu+wkNSZw6VE6sGtIGzg1gvInEhFnUJzyV7A5+seoNtcq0Yb3gtzNsid3w=="

# COMMAND ----------

# Set file location and file type

#file_location = "wasbs://datalake/BASE/StockPrices/EoD/20210731_EoDPrices.csv"
file_location = "wasbs://datalake@adlsazureproject2020.blob.core.windows.net/BASE/StockPrices/EoD/20210731_EoDPrices.csv"
file_type = "csv"

# COMMAND ----------

# Connect to Azure Storage using Key Vault
# https://docs.databricks.com/data/data-sources/azure/adls-gen2/azure-datalake-gen2-sp-access.html

spark.conf.set("fs.azure.account.auth.type." + storage_account_name + ".dfs.core.windows.net", "OAuth")
spark.conf.set("fs.azure.account.oauth.provider.type." + storage_account_name + ".dfs.core.windows.net", "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider")
spark.conf.set("fs.azure.account.oauth2.client.id." + storage_account_name + ".dfs.core.windows.net", "8558216d-445c-49ae-b341-ff8146c6d539")
spark.conf.set("fs.azure.account.oauth2.client.secret." + storage_account_name + ".dfs.core.windows.net", dbutils.secrets.get(scope="key-vault-secrets",key="ServicePrincipleSecret"))
spark.conf.set("fs.azure.account.oauth2.client.endpoint." + storage_account_name + ".dfs.core.windows.net", "https://login.microsoftonline.com/75099764-499a-4c9a-be3b-eb20119a46dd/oauth2/token")

# COMMAND ----------

# Load EoD prices into DF

dfEodPrices = spark.read.format(file_type).option("inferSchema", "true").option("header", "true").load(file_location)

# COMMAND ----------

# Create extra columns

dfEodPrices = dfEodPrices.withColumn("ID", concat(substring('date', 6, 2),substring('date', 1, 4) ) ) #\
                          #.withColumn("DailyReturn", dfEodPrices['close'].pct_change(1))

#display(dfEodPrices)

# COMMAND ----------

# Convert Spark dataframe to pandas for pct_change function use
dfEodPrices_pd = dfEodPrices.toPandas()

# Create new Daily Returns col
dfEodPrices_pd["DailyReturn"] = dfEodPrices_pd.groupby("Ticker")["close"].pct_change(1)

# Create Natural Log of daily returns
dfEodPrices_pd["LNDailyReturn"] = np.log(1 + dfEodPrices_pd["DailyReturn"])



# COMMAND ----------

print(dfEodPrices_pd)

# will need to convert pandas df back to spark df. faster

# COMMAND ----------


