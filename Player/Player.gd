extends KinematicBody2D


export var MAX_SPEED: int = 70
export var FRICTION: int = 1000
export var ACCELERATION: int = 500

var velocity: Vector2 = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")


# Called when the node enters the scene tree for the first time.
func _ready():
	animationTree.active = true


func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("WalkRight") - Input.get_action_strength("WalkLeft")
	input_vector.y = Input.get_action_strength("WalkDown") - Input.get_action_strength("WalkUp")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		animationState.travel("Walk")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	
	
	
	velocity = move_and_slide(velocity)
