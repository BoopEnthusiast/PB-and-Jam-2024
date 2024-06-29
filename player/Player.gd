class_name Player extends CharacterBody2D


const SPEED = 400.0
const ACCEL = SPEED * 10
const DECEL = ACCEL * 1.3


func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity = velocity.move_toward(direction * SPEED, ACCEL * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECEL * delta)
	
	move_and_slide()
