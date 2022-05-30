extends Area2D

#onready var scroll_rect = $ColorRect
onready var scroll_sprite = $Sprite
onready var scroll_menu = $ScrollMenu
onready var collider = $CollisionShape2D
onready var anim = $AnimationPlayer

func _ready():
#	scroll_rect.color.a = 0
	scroll_sprite.visible = false
	scroll_menu.visible = false

func _on_Scroll_body_entered(body):
	print("Grim touched the scroll")
	
	# Make scroll invisible and make scrollmenu visible
#	collider.disabled = true
	collider.queue_free()
#	scroll_rect.visible = false
	scroll_menu.visible = true
	scroll_menu.get_node("AnimationPlayer").play("UnrollScroll")
	body.frozen = true
	scroll_sprite.visible = false
	get_parent().show_button()


func _on_SpawnTimer_timeout():
	anim.play("Appear")
