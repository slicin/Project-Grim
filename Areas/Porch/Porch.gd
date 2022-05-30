extends Node2D

onready var grim_seated = $Death
onready var scythe = $Scythe
onready var dialogue_manager = $DialogueManager3
onready var response1 = $Response1
onready var response2 = $Response2

var player = null

func _ready():
	hide_response_buttons()

func _process(delta):
	if player and Input.is_action_just_pressed("interact"):
		print("Grim attempted to sit in chair")
		grim_seated.visible = true
		scythe.visible = true
		player.queue_free()
		dialogue_manager.begin_dialogue()

func restart_game():
	get_tree().change_scene("res://Areas/Underworld/Underworld.tscn")

func _on_ChairTrigger_body_entered(body):
	if body.has_method("heya_ima_grim"):
		player = body

func _on_ChairTrigger_body_exited(body):
	if body.has_method("heya_ima_grim"):
		player = null

func show_response_buttons():
	response1.visible = true
	response2.visible = true

func hide_response_buttons():
	response1.visible = false
	response2.visible = false
