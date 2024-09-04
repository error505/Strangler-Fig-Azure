// Parameters
param location string = resourceGroup().location
param appServicePlanName string = 'myAppServicePlan'
param appServiceLegacyName string = 'myLegacyAppService'
param functionAppNewName string = 'myNewFunctionApp'
param functionAppLegacyName string = 'myLegacyFunctionApp'
param apiManagementName string = 'myAPIM'
param keyVaultName string = 'myKeyVault'
param appInsightsName string = 'myAppInsights'
param storageAccountName string = 'mystorageaccount'
param cosmosDbAccountName string = 'myCosmosDbAccount'
param cosmosDbDatabaseName string = 'myDatabase'
param cosmosDbContainerName string = 'myContainer'

// Azure App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'P1v2'
    capacity: 1
  }
}

// Azure App Service (Legacy Monolithic Application)
resource appServiceLegacy 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceLegacyName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
      ]
    }
  }
}

// Azure Function App (New Feature Functionality)
resource functionAppNew 'Microsoft.Web/sites@2022-03-01' = {
  name: functionAppNewName
  location: location
  kind: 'functionapp'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'python'
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=<key>'
        }
        {
          name: 'COSMOS_DB_CONNECTION_STRING'
          value: cosmosDb.listKeys().primaryMasterKey
        }
      ]
    }
  }
}

// Azure API Management
resource apiManagement 'Microsoft.ApiManagement/service@2022-08-01' = {
  name: apiManagementName
  location: location
  sku: {
    name: 'Developer'
    capacity: 1
  }
  properties: {
    publisherEmail: 'admin@example.com'
    publisherName: 'ExamplePublisher'
  }
}

// Azure Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: []
  }
}

// Azure Application Insights
resource appInsights 'Microsoft.Insights/components@2022-07-01' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    RetentionInDays: 30
  }
}

// Azure Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

// Azure Cosmos DB Account
resource cosmosDb 'Microsoft.DocumentDB/databaseAccounts@2023-05-15' = {
  name: cosmosDbAccountName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
        failoverPriority: 0
      }
    ]
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
  }
}

// Azure Cosmos DB SQL Database
resource cosmosDbDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2023-05-15' = {
  parent: cosmosDb
  name: cosmosDbDatabaseName
  properties: {
    resource: {
      id: cosmosDbDatabaseName
    }
  }
}

// Azure Cosmos DB SQL Container
resource cosmosDbContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2023-05-15' = {
  parent: cosmosDbDatabase
  name: cosmosDbContainerName
  properties: {
    resource: {
      id: cosmosDbContainerName
      partitionKey: {
        paths: ['/partitionKey']
        kind: 'Hash'
      }
      defaultTtl: -1
    }
  }
}
