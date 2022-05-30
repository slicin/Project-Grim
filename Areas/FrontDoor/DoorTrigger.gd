extends Area2D

var player = null
var door_triggered = false

onready var dialogue_manager = get_parent().get_node("DialogueManager1")

func _process(delta):
	if !player:
		return
	if door_triggered:
		return
	if Input.is_action_just_pressed("interact"):
#		print("Grim just interacted with the door")
		player.frozen = true
		door_triggered = true
		dialogue_manager.begin_dialogue()

func _on_DoorTrigger_body_entered(body):
	if body.has_method("heya_ima_grim"):
		player = body

func _on_DoorTrigger_body_exited(body):
	if body.has_method("heya_ima_grim"):
		player = null
