extends Spatial

onready var player = get_node("/root/Game/Player")
var mode = "Idle"
var damage_rate = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(player.eyes.global_transform.origin, Vector3.UP)
	if is_on_screen() and $VisibilityNotifier.is_on_screen() and player.eyes_open:
		if mode == "Idle":
			mode = "Ticking"
			$AnimatedSprite3D.play("Ticking")
			$AlertSound.play()
		elif mode == "Ticking":
			# the frame_changed signal is janky so I have to do this instead
			if $AnimatedSprite3D.frame == 8:
				mode = "Attacking"
				$AnimatedSprite3D.play("Attacking")
		elif mode == "Attacking":
			player.health -= delta * damage_rate
			if not $AttackSound.playing:
				$AttackSound.play()
			if $AttackSound.get_playback_position() > 0.3:
				$AttackSound.play()
	else:
		mode = "Idle"
		$AnimatedSprite3D.play("Idle")

func is_on_screen():
	# special thanks to user unfa on this thread:
	# https://godotengine.org/qa/2843/how-to-check-if-an-object-is-visible-in-3d-view
	var camera = get_viewport().get_camera()
	var raycast = get_world().direct_space_state.intersect_ray(camera.global_transform.origin, self.global_transform.origin, [])
	if raycast.empty():
		return false
	elif raycast["collider"] == $VisibilityStaticBody:
		return true
	else:
		$Cursor.global_transform.origin = raycast["position"]
		return false
