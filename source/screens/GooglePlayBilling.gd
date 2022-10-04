extends Node

signal purchase_token_retrieved(token)

var payment
var token

func _ready():
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
		payment.connect("query_purchases_response", self, "_on_query_purchases_response")
		
		payment.startConnection()
	else:
		NetworkStateLabel.text = "google billing service not found"


func purchase_asset(playstore_id):
	NetworkStateLabel.show_purchasing()
	payment.querySkuDetails([playstore_id], "inapp")
	yield(payment, "sku_details_query_completed")
	payment.purchase(playstore_id)


func _on_connected():
	payment.queryPurchases("inapp")


func _on_disconnected():
	pass


func _on_connect_error(response_id, debug_message):
	NetworkStateLabel.text = "connection failed! \n error: %s" % debug_message
	NetworkStateLabel.show()
	yield(get_tree().create_timer(2.0), "timeout")
	NetworkStateLabel.hide()


func _on_query_purchases_response(query_result):
	for purchase in query_result.purchases:
		payment.acknowledgePurchase(purchase.purchase_token)


func _on_purchases_updated(purchases):
	for purchase in purchases:
		payment.acknowledgePurchase(purchase.purchase_token)


func _on_purchase_error(response_id, debug_message):
	NetworkStateLabel.text = "purchase failed! \n error: %s" % debug_message
	NetworkStateLabel.show()
	yield(get_tree().create_timer(2.0), "timeout")
	NetworkStateLabel.hide()


func _on_sku_details_query_completed(SKU_details):
	NetworkStateLabel.text = "sku loading completed"
	for available_sku in SKU_details:
		NetworkStateLabel.text = available_sku
	NetworkStateLabel.show()
	yield(get_tree().create_timer(2.0), "timeout")
	NetworkStateLabel.hide()


func _on_sku_details_query_error(response_id, debug_message, queried_SKUs):
	NetworkStateLabel.text = "sku details failed \n error: %s" % debug_message
	NetworkStateLabel.show()
	yield(get_tree().create_timer(2.0), "timeout")
	NetworkStateLabel.hide()


func _on_purchase_acknowledged(purchase_token):
	token = purchase_token
	emit_signal("purchase_token_retrieved", token)
	
	NetworkStateLabel.text = "purchase acknowledged!"
	NetworkStateLabel.show()
	yield(get_tree().create_timer(2.0), "timeout")
	NetworkStateLabel.hide()


func _on_purchase_acknowledgement_error(response_id, debug_message, purchase_token):
	NetworkStateLabel.text = "purchase acknowledgement failed \n error: %s" % debug_message
	NetworkStateLabel.show()
	yield(get_tree().create_timer(2.0), "timeout")
	NetworkStateLabel.hide()

