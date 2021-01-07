extends KinematicBody2D
class_name NPC

export var MAX_SPEED: int = 50
export var ACCELERATION: int = 500
export var FRICTION: int = 300
export var NAME: String
export var DIALOGUE: String

enum {
	IDLE
	WANDER,
	CHASE
}

var dialogue_state = 0
var dialoguePopup
var playerer

var velocity = Vector2.ZERO
var state = WANDER

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var playerDetectionZone = $PlayerDetectionZone
onready var wanderTimer = $WanderTimer

func _ready():
	animationTree.active = true
	dialoguePopup = get_tree().root.get_node("TestLevel/CanvasLayer/DialoguePopup")
	playerer = get_tree().root.get_node("TestLevel/YSort/Player")

func _physics_process(delta):
	
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			animationState.travel("Idle")
		WANDER:
			wanderTimer.paused = false
			velocity = velocity.move_toward(Vector2.RIGHT * MAX_SPEED, ACCELERATION * delta)
			animationState.travel("Walk")
			seek_player()
		CHASE:
			wanderTimer.paused = true
			MAX_SPEED = abs(MAX_SPEED)
			var player = playerDetectionZone.player
			
			if player != null:
				talk()
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				dialoguePopup.close()
				state = WANDER
				
	
	animationTree.set("parameters/Idle/blend_position", velocity)
	animationTree.set("parameters/Walk/blend_position", velocity)
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE
		


func _on_WanderTimer_timeout():
	#Setting it to WANDER right now for testing purposes
	#Might need to disable pending design decisions
	#state = WANDER
	MAX_SPEED *= -1


func talk():
	#dialoguePopup.npc = self
	dialoguePopup.npc_name = NAME
	dialoguePopup.dialogue = DIALOGUE
	dialoguePopup.open()
	
	


