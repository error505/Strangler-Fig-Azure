# Infrastructure Deployment with Bicep

This folder contains the **Bicep template** and the corresponding **GitHub Action** to deploy the Azure resources needed for the Strangler Fig Pattern implementation.

## 📑 Files

- **`azure-resources.bicep`**: The Bicep template file that defines all the necessary Azure resources, including App Service, Function Apps, API Management, Cosmos DB, Key Vault, and Application Insights.
- **`deploy-bicep.yml`**: GitHub Action workflow to automate the deployment of the infrastructure using the Bicep template.

## 🚀 How to Deploy

1. **Ensure you have the required permissions** to create Azure resources.
2. **Push changes** to the `main` branch to trigger the GitHub Action workflow.
3. The GitHub Action will use the Azure CLI to deploy the Bicep template.

## 🔧 Prerequisites

- **Azure CLI**: Required to run the deployment scripts in the GitHub Actions.
- **GitHub Secrets**: Ensure that `AZURE_CREDENTIALS`, `AZURE_CLIENT_ID`, `AZURE_CLIENT_SECRET`, and `AZURE_TENANT_ID` are configured.

## 📂 Folder Structure

- **`azure-resources.bicep`**: Bicep template for Azure resources.
- **`.github/workflows/deploy-bicep.yml`**: GitHub Actions workflow file.