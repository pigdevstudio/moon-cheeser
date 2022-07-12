extends Node


onready var google_billing = $GooglePlayBilling
onready var shop_httprequest = $ShopHTTPRequest


func _on_SkinButton_pressed(skin_id, playstore_id):
	google_billing.payment.querySkuDetails(["skin.sailor.moon"], "inapp")
	yield(google_billing.payment, "sku_details_query_completed")
	google_billing.payment.purchase(playstore_id)
	shop_httprequest.purchase(skin_id, google_billing.token)
