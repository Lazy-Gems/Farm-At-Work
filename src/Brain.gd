extends Node

var water: float = 0 : set = set_water
var max_water: float = 100
var water_fill_speed: float = 1.0

var money: float = 100 : set = set_money
var money_per_second: float = 0.25


func _ready() -> void:
	water = max_water
	$/root/Main/%WaterProgressBar.max_value = max_water
	money = money

func _physics_process(delta: float) -> void:
	money += delta * money_per_second
	if water < max_water:
		water += delta * water_fill_speed


func set_water(value):
	water = value
	$/root/Main/%WaterProgressBar.value = water
	$/root/Main/%WaterProgressLabel.text = str(ceili(water))


func set_money(value):
	money = value
	$/root/Main/%MoneyLabel.text = str(int(money))


func decline_buy():
	var tween := create_tween()
	tween.tween_property($/root/Main/%MoneyContainer, "modulate", Color.RED, 0.05)
	tween.tween_property($/root/Main/%MoneyContainer, "modulate", Color.WHITE, 0.3)
	

func decline_water():
	var tween := create_tween()
	tween.tween_property($/root/Main/%WaterContainer, "modulate", Color.RED, 0.05)
	tween.tween_property($/root/Main/%WaterContainer, "modulate", Color.WHITE, 0.3)
	
