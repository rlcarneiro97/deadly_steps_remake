extends Node2D

func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		exit_game()

func exit_game() -> void:
	get_tree().quit()
