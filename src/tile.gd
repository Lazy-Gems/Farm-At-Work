extends TextureRect

const PLANTS = [
	preload("res://src/assets/carrot.png"),
	preload("res://src/assets/onion.png"),
	preload("res://src/assets/radish.png"),
	preload("res://src/assets/potato.png"),
]

const plant_cost: float = 25
const water_cost: float = 15
const time_to_dry: float = 60
const time_to_evolve: float = 20

var plant: Texture
var plant_progress: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%WaterSprite.modulate.a = 0
	%Buttons.visible = false
	%Buttons.current_tab = 0
	plant = PLANTS.pick_random()
	%PlantButtonSprite.texture = plant


func _physics_process(delta: float) -> void:
	if %WaterSprite.modulate.a > 0:
		%WaterSprite.modulate.a -= delta / time_to_dry
		plant_progress += delta
		if %PlantSprite.frame < 3 and plant_progress >= time_to_evolve:
			%PlantSprite.frame = 3
		if %PlantSprite.frame < 4 and plant_progress >= time_to_evolve * 2:
			%PlantSprite.frame = 4
			%Buttons.current_tab = 2


func _on_mouse_entered() -> void:
	z_index = 2
	%Buttons.visible = true


func _on_mouse_exited() -> void:
	z_index = 0
	%Buttons.visible = false


func _on_plant_pressed() -> void:
	if Brain.money < plant_cost: return
	Brain.money -= plant_cost
	_on_mouse_exited()
	%PlantSprite.texture = plant
	%Buttons.current_tab = 1


func _on_water_pressed() -> void:
	if Brain.water < water_cost: return
	Brain.water -= water_cost
	%WaterSprite.modulate.a = 1


func _on_sell_pressed() -> void:
	Brain.money += plant_cost * 2
	plant_progress = 0
	%PlantSprite.texture = null
	%PlantSprite.frame = 2
	%Buttons.current_tab = 0
	plant = PLANTS.pick_random()
	%PlantButtonSprite.texture = plant
