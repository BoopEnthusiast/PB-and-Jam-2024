extends Node


var map_width = 5100.0


func random_point() -> Vector2:
	return Vector2(randf_range(-map_width / 2.0, map_width / 2.0), randf_range(map_width, 0.0))


func start_meeting() -> void:
	pass
