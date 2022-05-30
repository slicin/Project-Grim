extends KinematicBody2D

#onready var sprite_body = $Sprite
onready var anim = $AnimationPlayer

enum {
	LEFT,
	RIGHT
}

var facing = RIGHT

var speed = 300 # 150
var _velocity = Vector2.ZERO

var frozen = false

func _physics_process(delta: float) -> void:
	
	if frozen:
		anim.stop()
		return
	
	var _horizontal_direction = (
		Input.get_action_strength("move_right")
		- Input.get_action_strength("move_left")
	)
	
	var _vertical_direction = (
		Input.get_action_strength("move_up")
		- Input.get_action_strength("move_down")
	)
	
	if _horizontal_direction == 1:
		facing = RIGHT
	elif _horizontal_direction == -1:
		facing = LEFT
	
	match facing:
		RIGHT:
			if _horizontal_direction == 0 and _vertical_direction == 0:
				anim.play("IdleRight")
			else:
				anim.play("WalkRight")
		LEFT:
			if _horizontal_direction == 0 and _vertical_direction == 0:
				anim.play("IdleLeft")
			else:
				anim.play("WalkLeft")
	
	_velocity.x = _horizontal_direction
	_velocity.y = -_vertical_direction
	
	_velocity = move_and_slide(_velocity.normalized() * speed)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("interact"):
#		print("Attempted to interact")
		pass

func heya_ima_grim():
	pass
