extends Node2D

onready var grim = get_node("Grim")
onready var response1 = $Response1
onready var response2 = $Response2

func _ready():
	grim.frozen = true
	grim.visible = false
	response1.visible = false
	response2.visible = false

func show_grim():
	grim.frozen = false
	grim.visible = true

func _on_EnterHouseTrigger_body_entered(body):
	if body.has_method("heya_ima_grim"):
		get_tree().change_scene("res://Areas/Interior/Interior.tscn")
#		print("Progress to next scene")

func show_response_buttons():
	response1.visible = true
	response2.visible = true

func hide_response_buttons():
	response1.visible = false
	response2.visible = false
