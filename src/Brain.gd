extends Node

var max_water: float = 100
var water: float = 0 : set = set_water

var money: int = 100 : set = set_money


func _ready() -> void:
	water = max_water
	$/root/Main/%WaterProgressBar.max_value = max_water
	money = money

func _physics_process(delta: float) -> void:
	if water < max_water:
		water += delta


func set_water(value):
	water = value
	$/root/Main/%WaterProgressBar.value = water
	$/root/Main/%WaterProgressLabel.text = str(ceili(water))



func set_money(value):
	money = value
	$/root/Main/%MoneyLabel.text = str(money)
