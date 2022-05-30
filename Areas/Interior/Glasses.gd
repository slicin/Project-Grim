extends StaticBody2D

onready var thought_text = get_parent().get_parent().get_node("UI/ThoughtText")

func _on_Glasses_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		thought_text.text = "I could never wear these. They’d make my eye sockets look huge."
