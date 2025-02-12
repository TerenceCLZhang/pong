extends Area2D

signal ball_left


func _on_area_entered(_area: Area2D) -> void:
	ball_left.emit()
