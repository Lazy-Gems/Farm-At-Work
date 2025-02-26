extends Control

const Y_SIZE: int = 64

#var currencies_tween: Tween

func _ready() -> void:
	var rect := DisplayServer.screen_get_usable_rect()
	var pos := Vector2i(rect.position.x, rect.size.y - Y_SIZE + rect.position.y)
	
	set_screen_size()
	DisplayServer.window_set_position(pos)


func set_screen_size(plus: int = 0):
	var width: int = plus
	for c in %GridContainer.get_children():
		width += c.size.x
	DisplayServer.window_set_size(Vector2i(width - 1, Y_SIZE))
	DisplayServer.window_set_size(Vector2i(width, Y_SIZE))


func _on_add_tile_pressed() -> void:
	if Brain.money < 500: 
		Brain.decline_buy()
		return
	
	var tile: Control = load("res://src/tile.tscn").instantiate()
	var has_plant := false
	for c in %GridContainer.get_children():
		if c.get("planted"):
			has_plant = true
			break
	if not has_plant and Brain.money < 500 + tile.plant_cost:
		Brain.decline_buy()
		return
		
	Brain.money -= 500
	set_screen_size(64)
	#await get_tree().create_timer(1).timeout
	%GridContainer.add_child(tile)
	%GridContainer.move_child(tile, -2)


func _on_mouse_entered() -> void:
	pass

func _on_mouse_exited() -> void:
	pass


func _on_water_settings_button_pressed() -> void:
	%Settings.visible = !%Settings.visible
