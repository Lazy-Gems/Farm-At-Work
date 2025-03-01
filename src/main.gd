extends Control

const Y_SIZE: int = 64
const UPGRADE_COST: int = 250

#var currencies_tween: Tween

func _ready() -> void:
	var rect := DisplayServer.screen_get_usable_rect()
	var pos := Vector2i(rect.position.x, rect.size.y - Y_SIZE + rect.position.y)
	
	set_screen_size()
	DisplayServer.window_set_position(pos)
	%Settings.visible = false


func set_screen_size(plus: int = 0):
	var width: int = plus
	for c in %GridContainer.get_children():
		if not c.visible: continue
		width += c.size.x
	DisplayServer.window_set_size(Vector2i(width - 1, Y_SIZE))
	DisplayServer.window_set_size(Vector2i(width, Y_SIZE))


func _on_add_tile_pressed() -> void:
	if Brain.money < 500: 
		Brain.decline_buy()
		return
	
	var tile: Control = load("res://src/tile.tscn").instantiate()
	#var has_plant := false
	#for c in %GridContainer.get_children():
		#if c.get("planted"):
			#has_plant = true
			#break
	#if not has_plant and Brain.money < 500 + tile.plant_cost:
		#Brain.decline_buy()
		#return
		
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


func _on_upgrade_crop_pressed() -> void:
	pass # Replace with function body.


func _on_water_fill_speed_upgrade_pressed() -> void:
	if Brain.money < UPGRADE_COST: 
		Brain.decline_buy()
		return
	Brain.money -= UPGRADE_COST
	Brain.water_fill_speed += 0.1


func _on_max_water_upgrade_pressed() -> void:
	if Brain.money < UPGRADE_COST: 
		Brain.decline_buy()
		return
	Brain.money -= UPGRADE_COST
	Brain.max_water += 10


func _on_close_settings_pressed() -> void:
	%Settings.visible = false
