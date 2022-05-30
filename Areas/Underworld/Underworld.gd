extends Node2D

onready var button = $Button

func _ready():
	button.visible = false

func show_button():
	button.visible = true

func load_next_area():
	get_tree().change_scene("res://Areas/FrontDoor/FrontDoor.tscn")
	print("Uh hello?")
