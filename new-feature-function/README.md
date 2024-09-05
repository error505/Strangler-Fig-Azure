# New Feature Function (Azure Functions)

This folder contains the Python code for the new Azure Function that replaces part of the legacy application functionality, along with a GitHub Action workflow for deployment.

## 📑 Files

- **`function_app.py`**: Python code for the Azure Function that processes orders and stores data in Cosmos DB.
- **`requirements.txt`**: Lists the dependencies required by the Azure Function.
- **`deploy-functions.yml`**: GitHub Action workflow to automate the deployment of the Azure Function.

## 🚀 How to Deploy

1. **Ensure all files are in place** and properly configured.
2. **Push changes** to the `main` branch to trigger the GitHub Action workflow.
3. The GitHub Action will deploy the Azure Function to Azure.

## 🔧 Prerequisites

- **Azure CLI**: Required for manual deployment if needed.
- **GitHub Secrets**: Ensure that `AZURE_CREDENTIALS` and `AZURE_FUNCTIONAPP_PUBLISH_PROFILE` are configured.

## 📂 Folder Structure

- **`function_app.py`**: Azure Function code.
- **`requirements.txt`**: Python dependencies.
- **`.github/workflows/deploy-functions.yml`**: GitHub Actions workflow file.
