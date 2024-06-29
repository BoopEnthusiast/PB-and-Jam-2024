extends CharacterBody2D

var SPEED = 400

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	
	move_and_slide()
