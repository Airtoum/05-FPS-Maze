extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Play_pressed():
	print("play")
	get_tree().change_scene("res://Game.tscn")


func _on_Quit_pressed():
	print("quit")
	get_tree().quit()


func _on_Menu_pressed():
	get_tree().change_scene("res://UI/Menu.tscn")
