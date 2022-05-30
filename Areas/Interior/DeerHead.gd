extends StaticBody2D

onready var thought_text = get_parent().get_parent().get_node("UI/ThoughtText")

func _on_DeerHead_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		thought_text.text = "Hm a little morbid. I can’t imagine that lady shooting a deer. Maybe her husband..."
