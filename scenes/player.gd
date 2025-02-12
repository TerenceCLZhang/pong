extends CharacterBody2D

@export var speed := 200.0
@export var player := 1
@onready var player_sprite = $Sprite2D

func _process(_delta: float) -> void:
	move_paddle()


func _ready() -> void:
	center_player()


func move_paddle() -> void:
	var dy
	if player == 1: dy = Input.get_axis("up1", "down1")
	elif player == 2: dy = Input.get_axis("up2", "down2")
	else: printerr("ERROR: Player number does not exist.")
	dy = check_bounds(dy)
	velocity.y = dy * speed
	move_and_slide()


func check_bounds(dy: int) -> int:
	if (position.y <= 0 and dy < 0) or (position.y + get_sprite_dimensions()[1] >= get_viewport().get_size().y and dy > 0):
		dy = 0
	return dy


func center_player() -> void:
	var sprite_dimensions = get_sprite_dimensions()
	position.y = get_viewport_rect().size.y / 2 - sprite_dimensions[1] / 2
	if player == 1: position.x = 50
	elif player == 2: position.x = get_viewport_rect().size.x - 50
	else: printerr("ERROR: Player number does not exist.")
	position.x -= sprite_dimensions[0] / 2


func get_sprite_dimensions() -> Array:
	var sprite_width = player_sprite.texture.get_width() * player_sprite.scale.x
	var sprite_height = player_sprite.texture.get_height() * player_sprite.scale.y
	return [sprite_width, sprite_height]
