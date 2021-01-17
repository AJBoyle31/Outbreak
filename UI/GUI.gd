extends MarginContainer

signal game_over

var virus_meter = 100 setget set_meter
var max_virus_meter = 100 setget set_max_meter

onready var gauge = $HBoxContainer/Bars/Bar/Gauge
onready var stats = PlayerStats

func _ready():
	self.max_virus_meter = stats.max_health
	self.virus_meter = stats.health
	stats.connect("health_changed", self, "set_meter")
	stats.connect("max_health_changed", self, "set_max_meter")
	gauge.value = virus_meter

func _process(delta):
	pass


func set_meter(value):
	virus_meter = clamp(value, 0, max_virus_meter)
	gauge.value = virus_meter
	if virus_meter <= 0:
		print("DEAD")

func set_max_meter(value):
	pass
