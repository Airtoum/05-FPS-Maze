extends Spatial


onready var player = get_node("/root/Game/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	look_at(player.eyes.global_transform.origin, Vector3.UP)
