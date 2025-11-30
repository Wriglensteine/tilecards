extends Node

func _ready() -> void:
	print("State free roam: ", GlobalStateManager.free_roam)
	print("State in menu: ", GlobalStateManager.in_menu)
	print("State in shop: ", GlobalStateManager.in_shop)
