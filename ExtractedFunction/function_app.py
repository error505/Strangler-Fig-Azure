import azure.functions as func
import logging
import json
import os
from azure.cosmos import CosmosClient, exceptions

app = func.FunctionApp()

COSMOS_DB_CONNECTION_STRING = os.getenv('COSMOS_DB_CONNECTION_STRING')
COSMOS_DB_DATABASE_NAME = os.getenv('COSMOS_DB_DATABASE_NAME', 'myDatabase')
COSMOS_DB_CONTAINER_NAME = os.getenv('COSMOS_DB_CONTAINER_NAME', 'myContainer')

@app.route(route="ProcessingOrderRequest", auth_level=func.AuthLevel.ANONYMOUS)
def ProcessingOrderRequest(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('New feature function: Processing order request.')

    try:
        order_data = req.get_json()
        order_id = order_data.get('orderId')
        customer_name = order_data.get('customerName')

        if not order_id or not customer_name:
            raise ValueError('Order ID or Customer Name is missing')

        client = CosmosClient.from_connection_string(COSMOS_DB_CONNECTION_STRING)
        database = client.get_database_client(COSMOS_DB_DATABASE_NAME)
        container = database.get_container_client(COSMOS_DB_CONTAINER_NAME)

        container.upsert_item({
            'id': order_id,
            'customerName': customer_name,
            'orderData': order_data
        })

        logging.info(f"Order {order_id} saved to Cosmos DB for customer {customer_name}.")

        return func.HttpResponse(
            json.dumps({"message": f"Order {order_id} processed and saved to Cosmos DB successfully for {customer_name}."}),
            status_code=200,
            mimetype="application/json"
        )

    except ValueError as e:
        logging.error(f"Error processing order: {e}")
        return func.HttpResponse(
            json.dumps({"error": str(e)}),
            status_code=400,
            mimetype="application/json"
        )
    except exceptions.CosmosHttpResponseError as e:
        logging.error(f"Cosmos DB error: {e}")
        return func.HttpResponse(
            json.dumps({"error": "Cosmos DB error occurred."}),
            status_code=500,
            mimetype="application/json"
        )
    except Exception as e:
        logging.error(f"Unexpected error: {e}")
        return func.HttpResponse(
            json.dumps({"error": "An unexpected error occurred."}),
            status_code=500,
            mimetype="application/json"
        )
