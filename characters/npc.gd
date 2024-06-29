class_name NPC extends CharacterBody2D


const SPEED = 100.0

var ready_to_move := false

var last_position: Vector2

@onready var nav_agent = $NavAgent


func _ready():
	# Make sure to not await during _ready.
	call_deferred("actor_setup")


func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	
	# Now that the navigation map is no longer empty, set the movement target.
	nav_agent.target_position = Singleton.random_point()
	ready_to_move = true


func _physics_process(_delta):
	if not ready_to_move:
		return
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = nav_agent.get_next_path_position()
	
	nav_agent.velocity = current_agent_position.direction_to(next_path_position) * SPEED
	move_and_slide()


func _on_navigation_finished():
	nav_agent.target_position = Singleton.random_point()


func _on_velocity_computed(safe_velocity):
	velocity = safe_velocity


func _on_move_check_timeout():
	if last_position and last_position.distance_squared_to(global_position) < 500:
		nav_agent.target_position = Singleton.random_point()
	last_position = global_position
