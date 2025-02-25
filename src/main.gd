extends Control

const Y_SIZE: int = 64

#var currencies_tween: Tween

func _ready() -> void:
	var rect := DisplayServer.screen_get_usable_rect()
	var pos := Vector2i(rect.position.x, rect.size.y - Y_SIZE + rect.position.y)
	
	DisplayServer.window_set_size(Vector2i(600, Y_SIZE))
	DisplayServer.window_set_position(pos)


func _on_mouse_entered() -> void:
	pass

func _on_mouse_exited() -> void:
	pass
