extends Node2D

export var max_health = 100 setget set_max_health

onready var health = max_health setget set_health

#singals used to let the GUI know one of the variables have been changed
signal no_health
signal health_changed(value)
signal max_health_changed(value)

func _ready():
	self.health = max_health

#sets the health and then lets the GUI know to update its variable
func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

#this isn't needed for the player stats since we're only concerned about the player
func set_max_health(value):
	max_health = value
	#health = min(health, max_health)
	emit_signal("max_health_changed")
