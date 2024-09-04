from flask import Flask, jsonify, request
import logging
import os

app = Flask(__name__)

# Mock database for legacy app
legacy_orders = [
    {"orderId": "001", "customerName": "Alice", "product": "Laptop"},
    {"orderId": "002", "customerName": "Bob", "product": "Smartphone"}
]

# Legacy endpoint for retrieving order status
@app.route('/getOrderStatus', methods=['GET'])
def get_order_status():
    order_id = request.args.get('orderId')
    order = next((order for order in legacy_orders if order["orderId"] == order_id), None)

    if order:
        return jsonify({
            "orderId": order["orderId"],
            "status": "Processed",
            "product": order["product"]
        }), 200
    else:
        return jsonify({"error": "Order not found"}), 404

# Legacy endpoint for listing all orders
@app.route('/listOrders', methods=['GET'])
def list_orders():
    return jsonify({"orders": legacy_orders}), 200

# Legacy functionality for customer management
@app.route('/manageCustomer', methods=['POST'])
def manage_customer():
    try:
        customer_data = request.get_json()
        customer_name = customer_data.get("customerName")

        if not customer_name:
            raise ValueError("Customer name is missing")

        # Dummy customer management logic
        logging.info(f"Managing customer: {customer_name}")
        return jsonify({"message": f"Customer {customer_name} managed successfully."}), 200

    except Exception as e:
        logging.error(f"Error managing customer: {e}")
        return jsonify({"error": str(e)}), 400

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=int(os.environ.get("PORT", 5000)))
