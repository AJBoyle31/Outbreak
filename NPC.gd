extends KinematicBody2D
class_name NPC

export var MAX_SPEED: int = 50
export var ACCELERATION: int = 500
export var FRICTION: int = 300

enum {
	IDLE
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var state = IDLE

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func _physics_process(delta):
	
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			animationState.travel("Idle")
		WANDER:
			velocity = velocity.move_toward(Vector2.RIGHT * MAX_SPEED, ACCELERATION * delta)
			animationState.travel("Walk")
		CHASE:
			pass
	
	animationTree.set("parameters/Idle/blend_position", velocity)
	animationTree.set("parameters/Walk/blend_position", velocity)
	velocity = move_and_slide(velocity)



func _on_WanderTimer_timeout():
	#Setting it to WANDER right now for testing purposes
	#Might need to disable pending design decisions
	state = WANDER
	MAX_SPEED *= -1
