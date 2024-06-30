class_name Player extends CharacterBody2D


# Constants
const SPEED = 400.0
const ACCEL = SPEED * 10
const DECEL = ACCEL * 1.3

# Get nodes
@onready var interact_area = $InteractArea
@onready var phone = $Popup/Phone
@onready var phone_text = $Popup/Phone/PhoneText
@onready var paper = $Popup/Paper
@onready var paper_text = $Popup/Paper/PaperText
@onready var body_sprite = $Body
@onready var caught = $Caught
@onready var timer = $UI/ProgressBar/Timer

var interacting := false


func _physics_process(delta):
	# Interaction
	if Input.is_action_just_pressed("interact"):
		var just_switched = false
		if interacting:
			stop_interacting()
			just_switched = true
		if not interacting and not just_switched:
			for area in interact_area.get_overlapping_areas():
				if area is Paper:
					interacting = true
					paper_text.text = area.text
					paper.visible = true
					break
	
	elif Input.is_action_just_pressed("ui_cancel") and interacting:
		stop_interacting()
	
	# Movement
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction and not interacting:
		velocity = velocity.move_toward(direction * SPEED, ACCEL * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECEL * delta)
	
	move_and_slide()
	
	body_sprite.rotation = rotate_toward(body_sprite.rotation, velocity.angle() - PI / 2, 0.05)


func stop_interacting() -> void:
	interacting = false
	phone.visible = false
	paper.visible = false


func increase_time() -> void:
	caught.play()
	timer.wait_time = timer.time_left - 10
	timer.start()
