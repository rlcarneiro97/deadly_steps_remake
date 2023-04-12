extends Node2D

func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		exit_game()
	if Input.is_action_just_pressed("reload_scene"):
		reload_game()

func exit_game() -> void:
	get_tree().quit()
	
func reload_game() -> void:
	get_tree().reload_current_scene()
