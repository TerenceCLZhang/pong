extends Node2D

@onready var player1 = $Objects/Player
@onready var player2 = $Objects/Player2
@onready var ball = $Objects/Ball
const pause_menu_scene = preload("res://scenes/pause_menu.tscn")
var is_paused = false
var player_speed: float
var ball_speed: float
var pause_menu: Control


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()


func toggle_pause():
	is_paused = !is_paused
	if is_paused:
		player_speed = player1.speed
		ball_speed = ball.speed
		player1.speed = 0
		player2.speed = 0
		ball.speed = 0
		ball.timer.paused = true
		pause_menu = pause_menu_scene.instantiate()
		$Display.add_child(pause_menu)
	else:
		player1.speed = player_speed
		player2.speed = player_speed
		ball.speed = ball_speed
		ball.timer.paused = false
		pause_menu.queue_free()


func _on_left_edge_ball_left() -> void:
	ball.prev_lost_player = 1
	player_score()


func _on_right_edge_ball_left() -> void:
	ball.prev_lost_player = 2
	player_score()


func player_score() -> void:
	$Sounds/Score.play()
	ball.reset_ball()
