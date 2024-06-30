class_name NPC extends CharacterBody2D


const SPEED = 100.0
const TURN_SPEED = PI

var ready_to_move := false
var last_position: Vector2
var doing_thing: Node2D
var holding_paper := false
var body_x: Array[float] = [2334.242, 1805.482, 1329.457]
var head_x: Array[float] = [2535.604, 2204.204, 1632.709, 1331.534]

@onready var nav_agent = $NavAgent
@onready var wall_there = $WallThere
@onready var action_timer = $ActionTimer
@onready var body_sprite = $Body
@onready var head_sprite = $Head


func _ready():
	body_sprite.texture = body_sprite.texture.duplicate()
	head_sprite.texture = head_sprite.texture.duplicate()
	body_sprite.texture.region.position.x = body_x.pick_random()
	head_sprite.texture.region.position.x = head_x.pick_random()
	
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
	
	
	body_sprite.rotation = rotate_toward(body_sprite.rotation, velocity.angle(), 0.05)
	head_sprite.rotation = rotate_toward(head_sprite.rotation, velocity.angle(), 0.07)


func _on_navigation_finished():
	if ready_to_move:
		if doing_thing:
			if not doing_thing.visible:
				doing_thing.visible = true
				holding_paper = false
			else:
				nav_agent.target_position = doing_thing.global_position
				action_timer.start(randf_range(15, 35))
				ready_to_move = false
		nav_agent.target_position = Singleton.random_point()


func _on_velocity_computed(safe_velocity):
	velocity = safe_velocity


func _on_move_check_timeout():
	if last_position and last_position.distance_squared_to(global_position) < 300 and ready_to_move:
		nav_agent.target_position = Singleton.random_point()
	last_position = global_position


func _on_interaction_area_area_entered(area):
	if not doing_thing:
		if area is Paper:
			if area.visible:
				wall_there.target_position = to_local(area.global_position)
				if wall_there.get_collider() is Table:
					doing_thing = area
					nav_agent.target_position = area.global_position
			elif holding_paper:
				wall_there.target_position = to_local(area.global_position)
				if wall_there.get_collider() is Table:
					doing_thing = area
					nav_agent.target_position = area.global_position


func _on_action_timer_timeout():
	ready_to_move = true
	doing_thing.visible = false
	holding_paper = true
	doing_thing = null
