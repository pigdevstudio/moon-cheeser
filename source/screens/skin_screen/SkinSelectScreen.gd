extends Control

export(PackedScene) var skin_button

onready var shop = $SkinsShopScrollContainer
onready var inventory = $InventoryScrollContainer
onready var fade_rect = $FadeRect


func _ready():
	NetworkStateLabel.show_loading_skins()
	inventory.load_skins()
	yield(shop.load_skins(), "completed")
	NetworkStateLabel.show_skins_loaded()


func _on_Inventory_skin_selected():
	fade_rect.change_scene()
