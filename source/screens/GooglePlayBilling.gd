extends Node

signal purchase_token_retrieved(token)

var payment
var token

func _ready():
	if not OS.get_name() == "Android":
		return
	
	if Engine.has_singleton("GodotGooglePlayBilling"):
		payment = Engine.get_singleton("GodotGooglePlayBilling")
		
		payment.connect("connected", self, "_on_connected") # No params
		payment.connect("disconnected", self, "_on_disconnected") # No params
		payment.connect("connect_error", self, "_on_connect_error") # Response ID (int), Debug message (string)
		payment.connect("purchases_updated", self, "_on_purchases_updated") # Purchases (Dictionary[])
		payment.connect("purchase_error", self, "_on_purchase_error") # Response ID (int), Debug message (string)
		payment.connect("sku_details_query_completed", self, "_on_sku_details_query_completed") # SKUs (Dictionary[])
		payment.connect("sku_details_query_error", self, "_on_sku_details_query_error") # Response ID (int), Debug message (string), Queried SKUs (string[])
		payment.connect("purchase_acknowledged", self, "_on_purchase_acknowledged") # Purchase token (string)
		payment.connect("purchase_acknowledgement_error", self, "_on_purchase_acknowledgement_error") # Response ID (int), Debug message (string), Purchase token (string)
		payment.connect("purchase_consumed", self, "_on_purchase_consumed") # Purchase token (string)
		payment.connect("purchase_consumption_error", self, "_on_purchase_consumption_error") # Response ID (int), Debug message (string), Purchase token (string)
		payment.connect("query_purchases_response", self, "_on_query_purchases_response")
		
		payment.startConnection()
	else:
		NetworkStateLabel.text = "google billing service not found"


func _on_connected():
	payment.queryPurchases("inapp")


func _on_disconnected():
	pass


func _on_connect_error(response_id, debug_message):
	NetworkStateLabel.text = "connection failed! \n error: %s" % debug_message
	NetworkStateLabel.show()


func _on_query_purchases_response(query_result):
	if query_result.status == OK:
		for purchase in query_result.purchases:
			if not purchase.is_acknowledged:
				payment.acknowledgePurchase(purchase.purchase_token)


func _on_purchases_updated(purchases):
	for purchase in purchases:
		if not purchase.is_acknowledged:
			payment.acknowledgePurchase(purchase.purchase_token)


func _on_purchase_error(response_id, debug_message):
	NetworkStateLabel.text = "purchase failed! \n error: %s" % debug_message
	NetworkStateLabel.show()


func _on_sku_details_query_completed(SKUs):
	NetworkStateLabel.text = "sku loading completed"
	NetworkStateLabel.show()


func _on_sku_details_query_error(response_id, debug_message, queried_SKUs):
	NetworkStateLabel.text = "sku details failed \n error: %s" % debug_message
	NetworkStateLabel.show()


func _on_purchase_acknowledged(purchase_token):
	NetworkStateLabel.text = "purchase acknowledged!"
	NetworkStateLabel.show()
	token = purchase_token
	emit_signal("purchase_token_retrieved", token)


func _on_purchase_acknowledgement_error(response_id, debug_message, purchase_token):
	NetworkStateLabel.text = "purchase acknowledgement failed \n error: %s" % debug_message
	NetworkStateLabel.show()


func _on_purchase_consumed(purchase_token):
	NetworkStateLabel.text = "purchase consumed!"
	NetworkStateLabel.show()


func _on_purchase_consumption_error(response_id, debug_message, purchase_token):
	NetworkStateLabel.text = "purchase consumption failed \n error: %s" % debug_message
	NetworkStateLabel.show()
