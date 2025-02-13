extends Area2D

@onready var ball_sprite = $Sprite2D
@onready var timer = $Timer
@export var speed := 250
var spawn_positions := []
var direction_player = 1
var dx := -1
var dy := -1
var prev_lost_player = 1
var can_move := false


func _ready() -> void:
	get_spawn_positions()
	reset_ball()


func _process(delta: float) -> void:
	if can_move:
		position.x += speed * dx * delta
		position.y += speed * dy * delta
		dy = check_bounds()


func reset_ball() -> void:
	can_move = false
	self.visible = false
	timer.start()
	get_initial_direction()
	self.position = spawn_positions.pick_random()


func get_initial_direction() -> void:
	if prev_lost_player == 1:
		dx = -1
		dy = -1
	elif prev_lost_player == 2:
		dx = 1
		dy = 1
	else: printerr("ERROR: Player does not exist.")


func check_bounds() -> int:
	if position.y <= 0 or position.y >= get_viewport_rect().size.y - ball_sprite.texture.get_height() * ball_sprite.scale.y:
		dy *= -1
	return dy


func get_spawn_positions() -> void:
	var ball_size = ball_sprite.get_rect().size * ball_sprite.scale
	var viewport_height = get_viewport_rect().size.y
	var viewport_width = get_viewport_rect().size.x
	spawn_positions.append(Vector2(viewport_width / 2 - ball_size.x / 2, 50))
	spawn_positions.append(Vector2(viewport_width / 2 - ball_size.x / 2, viewport_height - 50))


func _on_body_entered(_body: Node2D) -> void:
	dx *= -1
	dy *=- -1
	$Sounds/Hit.play()


func _on_timer_timeout() -> void:
	can_move = true
	self.visible = true
