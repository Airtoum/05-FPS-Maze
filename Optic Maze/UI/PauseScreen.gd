extends Control


onready var global = get_node("/root/Global")
var remapping_what = null


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	update_button_text()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused
		if get_tree().paused:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if not visible:
		return
		
func update_button_text():
	set_button_text($InputForward, "Forward", "up")
	set_button_text($InputBack, "Back", "down")
	set_button_text($InputLeft, "Left", "left")
	set_button_text($InputRight, "Right", "right")
	set_button_text($InputJump, "Jump", "jump")
	set_button_text($InputEyes, "Close Eyes", "close_eyes")
	
func set_button_text(button, action_name, action):
	if remapping_what == action:
		button.text = action_name + ": [press key]"
	else:
		button.text = action_name + ": " + InputMap.get_action_list(action)[0].as_text()
		
func _input(event):
	if event is InputEventKey and remapping_what != null:
		InputMap.action_erase_events(remapping_what)
		InputMap.action_add_event(remapping_what, event)
		remapping_what = null
		update_button_text()
		global.save_input()


func _on_Resume_pressed():
	get_tree().paused = false
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_InputForward_pressed():
	remapping_what = "up"
	update_button_text()


func _on_InputBack_pressed():
	remapping_what = "down"
	update_button_text()


func _on_InputLeft_pressed():
	remapping_what = "left"
	update_button_text()


func _on_InputRight_pressed():
	remapping_what = "right"
	update_button_text()


func _on_InputJump_pressed():
	remapping_what = "jump"
	update_button_text()


func _on_InputEyes_pressed():
	remapping_what = "close_eyes"
	update_button_text()


func _on_Quit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://UI/Menu.tscn")
