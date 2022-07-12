extends Node

signal purchase_token_retrieved(token)

var payment
var token

onready var debug_label = Label.new()

func _ready():
	debug_label.hide()
	add_child(debug_label)
	debug_label.rect_global_position = Vector2(1280 / 2, 720 / 2)
	
	debug_label.text = "debug label"
	
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
		debug_label.text = "singleton not found"


func _on_connected():
	debug_label.text = "connected"
	payment.queryPurchases("inapp")


func _on_disconnected():
	pass


func _on_connect_error(response_id, debug_message):
	pass


func _on_query_purchases_response(query_result):
	if query_result.status == OK:
		for purchase in query_result.purchases:
			if not purchase.is_acknowledged:
				print("Purchase " + str(purchase.sku) + " has not been acknowledged. Acknowledging...")
				payment.acknowledgePurchase(purchase.purchase_token)


func _on_purchases_updated(purchases):
	for purchase in purchases:
		if not purchase.is_acknowledged:
			DebugLabel.text = "purchase " + str(purchase.sku) + " has not been acknowledged. Acknowledging..."
			payment.acknowledgePurchase(purchase.purchase_token)


func _on_purchase_error(response_id, debug_message):
	pass


func _on_sku_details_query_completed(SKUs):
	pass


func _on_sku_details_query_error(response_id, debug_message, queried_SKUs):
	pass


func _on_purchase_acknowledged(purchase_token):
	DebugLabel.text = "purchase acknolodged: %s" % purchase_token
	token = purchase_token
	emit_signal("purchase_token_retrieved", token)


func _on_purchase_acknowledgement_error(response_id, debug_message, purchase_token):
	pass


func _on_purchase_consumed(purchase_token):
	pass


func _on_purchase_consumption_error(response_id, debug_message, purchase_token):
	pass

