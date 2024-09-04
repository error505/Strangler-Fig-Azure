# Legacy Application (Azure App Service)

This folder contains the Python code for the legacy monolithic application and the GitHub Action workflow to deploy it to **Azure App Service**.

## 📑 Files

- **`app.py`**: The main Python application file representing the legacy app.
- **`requirements.txt`**: Lists all the dependencies required by the legacy application.
- **`Procfile`**: Specifies the command to run the Python application on Azure App Service.
- **`deploy-legacy-app.yml`**: GitHub Action workflow to automate the deployment of the legacy app.

## 🚀 How to Deploy

1. **Ensure all files are in place** and properly configured.
2. **Push changes** to the `main` branch to trigger the GitHub Action workflow.
3. The GitHub Action will deploy the legacy Python app to Azure App Service.

## 🔧 Prerequisites

- **Azure CLI**: Required for manual deployment if needed.
- **GitHub Secrets**: Ensure that `AZURE_CREDENTIALS` is configured.

## 📂 Folder Structure

- **`app.py`**: Legacy Python app code.
- **`requirements.txt`**: Python dependencies.
- **`Procfile`**: Instructions for running the app on Azure.
- **`.github/workflows/deploy-legacy-app.yml`**: GitHub Actions workflow file.