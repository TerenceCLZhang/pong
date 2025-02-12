extends Node2D


const ball_scene = preload("res://scenes/ball.tscn")

func _ready() -> void:
	var ball = ball_scene.instantiate()
	add_child(ball)
	
	await get_tree().create_timer(2).timeout
		
	if ball.has_method("reset_ball"): ball.reset_ball()
	else: printerr("ERROR: 'reset_ball()' method not found on ball_instance.")
