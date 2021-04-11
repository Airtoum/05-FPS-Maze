extends Spatial

onready var player = get_node("/root/Game/Player")
onready var gridmap = get_node("/root/Game/GridMap")

var base_height
var amplitude = 0.2
var move_speed = 3
var damage_rate = 40
var float_timer = 0.0
var float_speed_multiplier = 4
var rotation_speed_multiplier = 1
var mode = "Freeze"
var last_seen_player = null
var target_position = null
var velocity = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	base_height = translation.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_on_screen() and $VisibilityNotifier.is_on_screen() and player.eyes_open:
		mode = "Freeze"
	else:
		mode = "Chase"

func _physics_process(delta):
	translation.y = base_height + amplitude * sin(4 * float_timer)
	velocity = Vector3.ZERO
	if mode == "Chase":
		float_timer = fposmod(float_timer + delta, 2 * PI)
		rotate(Vector3.RIGHT, rotation_speed_multiplier * delta)
		rotate_object_local(Vector3.UP, rotation_speed_multiplier * 0.18212 * delta)
		scan(Vector3.FORWARD)
		scan(Vector3.LEFT)
		scan(Vector3.BACK)
		scan(Vector3.RIGHT)
		if target_position != null:
			var flattened_target = Vector3(target_position.x, 0, target_position.z)
			var flattened_pos = Vector3(translation.x, 0, translation.z)
			var flattened_displacement = flattened_target - flattened_pos
			if flattened_displacement.length() < 0.2:
				translation.x = target_position.x
				translation.z = target_position.z
				target_position = null
			velocity = flattened_displacement.normalized() * move_speed * delta
		if (global_transform.origin - player.translation).length() < 1.4 :
			player.health -= delta * damage_rate
			$AttackSound.play()
	global_translate(velocity)
	
func is_on_screen():
	# special thanks to user unfa on this thread:
	# https://godotengine.org/qa/2843/how-to-check-if-an-object-is-visible-in-3d-view
	var camera = get_viewport().get_camera()
	var raycast = get_world().direct_space_state.intersect_ray(camera.global_transform.origin, self.global_transform.origin, [])
	if raycast.empty():
		return false
	elif raycast["collider"] == $VisibilityKinematicBody:
		return true
	else:
		return false

func scan(direction):
	var end_point = self.global_transform.origin + (direction * 50)
	var raycast = get_world().direct_space_state.intersect_ray(self.global_transform.origin, end_point, [player])
	var scan_to = end_point
	if raycast.empty():
		scan_to = end_point
	else:
		scan_to = raycast["position"]
	var tiles_out = 0
	var starting_tile = gridmap.world_to_map(translation)
	var p_grid_pos = gridmap.world_to_map(player.translation)
	while tiles_out < 20:
		var grid_pos = starting_tile + direction * tiles_out
		var tile_dist = (gridmap.map_to_world(grid_pos.x, grid_pos.y, grid_pos.z) - global_transform.origin).length()
		if tile_dist > (scan_to - global_transform.origin).length():
			break
		if grid_pos == p_grid_pos:
			last_seen_player = grid_pos
			target_position = gridmap.map_to_world(grid_pos.x, grid_pos.y, grid_pos.z)
			#print(target_position)
		tiles_out += 1
