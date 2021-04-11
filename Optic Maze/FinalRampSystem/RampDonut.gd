extends Area


export var my_ramp_path: String
var my_ramp


# Called when the node enters the scene tree for the first time.
func _ready():
	my_ramp = get_node(my_ramp_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RampDonut_body_entered(body):
	my_ramp.operation = CSGShape.OPERATION_UNION
	queue_free()
