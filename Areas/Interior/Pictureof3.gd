extends StaticBody2D

onready var thought_text = get_parent().get_parent().get_node("UI/ThoughtText")

func _on_Pictureof3_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		thought_text.text = "That must be her family. Her husband wasn’t quite so accepting if I recall. They all look happy here."
