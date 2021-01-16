extends MarginContainer

signal game_over

var virus_meter = 100 setget set_meter
var max_virus_meter = 100 setget set_max_meter

onready var gauge = $HBoxContainer/Bars/Bar/Gauge

func _ready():
	gauge.value = virus_meter

func set_meter(value):
	virus_meter = clamp(value, 0, max_virus_meter)
	gauge.value = virus_meter
	


func set_max_meter(value):
	pass
