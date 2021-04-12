extends Node

const SAVE_PATH = "res://settings.cfg"
var save_file = ConfigFile.new()
var saved_inputs = ["up", "down", "left", "right", "jump", "close_eyes"]

var esc_hold_timer = 0.0

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	load_input()

func _process(delta):
	if Input.is_action_pressed("quit"):
		esc_hold_timer += delta
		if esc_hold_timer > 0.6:
			get_tree().quit()
	else:
		esc_hold_timer = 0


func load_input():
	var error = save_file.load(SAVE_PATH)
	if error != OK:
		print("Failed loading file")
		return
	
	for i in saved_inputs:
		var key = save_file.get_value("Inputs", i, null)
		InputMap.action_erase_events(i)
		InputMap.action_add_event(i, key)


func save_input():
	for i in saved_inputs:
		var actions = InputMap.get_action_list(i)
		for a in actions:
			save_file.set_value("Inputs", i, a)
	save_file.save(SAVE_PATH)
