extends Node2D

export var file = 'res://Dialogue/granny_dialogue.txt'
onready var text = $ChatBubble/Label
onready var chat_bubble = $ChatBubble
onready var button = $ChatBubble/Button
onready var restart_button = get_parent().get_node("Node2D/Restart")
#onready var restart_button = get_parent().get_node("Restart")
onready var response1 = get_parent().get_node("Response1")
onready var response2 = get_parent().get_node("Response2")

onready var audio = get_parent().get_node("AudioStreamPlayer")
onready var end_anim = get_parent().get_node("AnimationPlayer")

var index = 1
var loaded_file
var skip = false
var skip_count = 2

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
	
	var audio_path = "res://Areas/Porch/Voice/{num}.mp3"
	var real_path = audio_path.format({"num": str(index)})
#	print(real_path)
	if load(real_path):
		audio.stream = load(real_path)
		audio.play()
	
	print(line + " " + str(index) + " " + str(line_length))
	index += 1
	
	if loaded_file.eof_reached():
		button.visible = false
		if restart_button:
			restart_button.visible = true
		end_anim.play("FadeOut")

	if index == 4:
		get_parent().show_response_buttons()
		button.visible = false
		response1.text = "It’s very nicely decorated."
		response2.text = "I've seen worse."
	
	if index == 6 and skip:
		skip_lines()
	
	if index == 22:
		get_parent().show_response_buttons()
		button.visible = false
		response1.text = "Take a cookie"
		response2.text = "Decline"

	if index == 24 and skip:
		skip_lines()

	if index == 47:
		get_parent().show_response_buttons()
		button.visible = false
		response1.text = "He was brave."
		response2.text = "He couldn't accept it."
#		skip_count = 3
	
	if index == 50 and skip:
		skip_lines()
	
	if index == 63:
		get_parent().show_response_buttons()
		button.visible = false
		response1.text = "You’ve got nothing to worry about."
		response2.text = "Come and I’ll show you."
		skip_count = 1
	
	if index == 67 and skip:
		skip_lines()
	
	if index == 74:
		get_parent().show_response_buttons()
		button.visible = false
		response1.text = "The most delicious cookies."
		response2.text = "To die for."
		skip_count = 2
	
	if index == 77 and skip:
		skip_lines()

func _on_Response1_button_up():
	read_next_line()
	get_parent().hide_response_buttons()
	button.visible = true
	skip = true

func _on_Response2_button_up():
	if index == 47:
		skip_count = 3
	if index == 63:
		skip_count = 4
	if index == 74:
		skip_count = 3
	skip_lines()
	read_next_line()
	get_parent().hide_response_buttons()
	button.visible = true

func skip_lines():
	for n in range(skip_count):
		loaded_file.get_line()
	index += skip_count
	skip = false
