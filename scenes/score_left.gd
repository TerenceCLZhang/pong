extends Label


func _on_right_edge_ball_left() -> void:
	self.text = str(int(self.text) + 1)
