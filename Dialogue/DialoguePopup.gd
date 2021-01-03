extends Popup

var npc_name setget name_set
var dialogue setget dialogue_set
var answers setget answers_set
var npc

onready var npcName = $ColorRect/NPCName
onready var npcDialogue = $ColorRect/Dialogue
onready var npcAnswers = $ColorRect/Answers
onready var animationPlayer = $AnimationPlayer

func name_set(new_value):
	npc_name = new_value
	npcName.text = new_value

func dialogue_set(new_value):
	dialogue = new_value
	npcDialogue.text = new_value

func answers_set(new_value):
	answers = new_value
	npcAnswers.text = new_value

func open():
	#get_tree().paused = true
	popup()
	#animationPlayer.playback_speed = 60.0 / dialogue.length()
	#animationPlayer.play("ShowDialogue")

func close():
	get_tree().paused = false
	hide()

func _on_AnimationPlayer_animation_finished(anim_name):
	set_process_input(true)
	

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_C:
			close()
		elif event.scancode == KEY_B:
			set_process_input(false)
