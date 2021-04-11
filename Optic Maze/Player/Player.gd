extends KinematicBody

onready var VisitedLight = load("res://VisitedLight.tscn")

onready var global = get_node("/root/Global")
onready var gridmap = get_node("/root/Game/GridMap")
onready var eyes = $Eyes

var move_speed = 3
var jump_speed = 6
var mouse_sensitivity = (1.0 / 5.0) * (PI / 180) # 1 degree per 5 pixels
var invert_y = false
var y_inversion_scale = -1.0 if invert_y else 1.0

var velocity = Vector3.ZERO
var gravity = -12
var visited_tiles = []
var eyes_open = true
var health = 100
var max_health
var health_bar_width
var is_dead = false
var death_timer = 0.0
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	max_health = health
	health_bar_width = $HPBar/Health.rect_size.x

func _process(_delta):
	eyes_open = not Input.is_action_pressed("close_eyes")
	$Eyelids.visible = not eyes_open
	$HPBar/Health.rect_size.x = float(health) / float(max_health) * health_bar_width
	$DeathScreen.visible = is_dead
	$Gold.text = str(score) + " COINS"

func _physics_process(delta):
	is_dead = health <= 0
	if is_dead:
		death_timer += delta
		if death_timer >= 1.8:
			get_tree().reload_current_scene()
		return
	var move_vel = input_velocity().normalized() * move_speed
	velocity.x = move_vel.x
	velocity.y += gravity * delta
	velocity.z = move_vel.z
	velocity = move_and_slide(velocity, Vector3.UP, true)
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += jump_speed
	var grid_pos = gridmap.world_to_map(translation)
	if gridmap.get_cell_item(grid_pos.x, grid_pos.y, grid_pos.z) != GridMap.INVALID_CELL_ITEM:
		if not grid_pos in visited_tiles:
			#print("New tile!" + str(grid_pos))
			visited_tiles.append(grid_pos)
			var visitedlight = VisitedLight.instance()
			get_parent().get_node("VisitedLights").add_child(visitedlight)
			visitedlight.translation = gridmap.map_to_world(grid_pos.x, grid_pos.y, grid_pos.z)
			visitedlight.translation.y += 1.6

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Eyes.rotate_x(y_inversion_scale * event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		#$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)

func input_velocity():
	var acc = Vector3.ZERO
	if Input.is_action_pressed("up"):
		acc += Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
	if Input.is_action_pressed("left"):
		acc += Vector3.LEFT.rotated(Vector3.UP, rotation.y)
	if Input.is_action_pressed("right"):
		acc += Vector3.RIGHT.rotated(Vector3.UP, rotation.y)
	if Input.is_action_pressed("down"):
		acc += Vector3.BACK.rotated(Vector3.UP, rotation.y)
	return - acc # it ended up being backwards
		
