extends Control

var game: Node2D


func _ready() -> void:
	game = get_parent()
	var width = get_viewport_rect().size.x / 2 - self.size.x / 2
	var height = get_viewport_rect().size.y / 2 - self.size.y / 2
	self.position = Vector2(width, height)


func _on_resume_pressed() -> void:
	game.toggle_pause()


func _on_reset_pressed() -> void:
	for child in game.get_children():
		if child is Label:
			child.text = "0"
		elif child.name == "Ball":
			child.reset_ball()
		elif child is CharacterBody2D:
			child.center_player()
		
	_on_resume_pressed()


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
