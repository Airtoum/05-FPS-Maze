extends Area

onready var player = get_node("/root/Game/Player")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Chest_body_entered(body):
	if body == player:
		player.score += 10
		queue_free()
