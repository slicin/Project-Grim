extends Node2D

export var file = 'res://Dialogue/dialogue_front.txt'
onready var text = $ChatBubble/Label
onready var chat_bubble = $ChatBubble
onready var button = $ChatBubble/Button
onready var restart_button = get_parent().get_node("Restart")

onready var door_open = get_parent().get_node("DoorOpen")
onready var door_closed = get_parent().get_node("DoorClosed")
onready var granny = get_parent().get_node("Granny")
onready var door_barrier = get_parent().get_node("HouseBarrierMiddle")

onready var audio = get_parent().get_node("AudioStreamPlayer")

var index = 1
var loaded_file

var skip = false

func _ready():
	load_dialogue(file)
	chat_bubble.visible = false

func load_dialogue(file):
	loaded_file = File.new()
	loaded_file.open(file, File.READ)

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func begin_dialogue():
	chat_bubble.visible = true
	read_next_line()

func read_next_line():
	
	var line = loaded_file.get_line()
	var line_length = line.length()
	text.text = line
	
	var audio_path = "res://Areas/FrontDoor/Voice/{num}.mp3"
	var real_path = audio_path.format({"num": str(index)})
#	print(real_path)
	if load(real_path):
		audio.stream = load(real_path)
		audio.play()
	
	print(line + " " + str(index) + " " + str(line_length))
	index += 1
	
	if loaded_file.eof_reached():
		button.visible = false
		chat_bubble.visible = false
		get_parent().get_node("Grim").frozen = false
		if restart_button:
			restart_button.visible = true
		
		# Remove granny and prepare door for entry
		granny.queue_free()
		door_barrier.queue_free()
	
	# Open door and show granny
	if index == 4:
		door_closed.visible = false
		door_open.visible = true
		granny.visible = true
		
		button.visible = false
		get_parent().show_response_buttons()
	
	if skip:
#		print("Attempting to skip next line")
		loaded_file.get_line()
		index += 1
		skip = false

func _on_Response1_button_up():
	skip = true
	read_next_line()
	get_parent().hide_response_buttons()
	button.visible = true

func _on_Response2_button_up():
	loaded_file.get_line()
	index += 1
	read_next_line()
	get_parent().hide_response_buttons()
	button.visible = true
