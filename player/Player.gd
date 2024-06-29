class_name Player extends CharacterBody2D


const SPEED = 400.0
const ACCEL = SPEED / 3.0
const DECEL = ACCEL / 2.0


func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity = velocity.move_toward(direction * SPEED, ACCEL)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECEL)
	
	move_and_slide()
