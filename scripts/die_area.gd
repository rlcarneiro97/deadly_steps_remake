extends Area2D

var next_scene_validator := false

func _process(_delta):
	skip()

func skip() -> void:
	
	if next_scene_validator:
		next_scene_validator = false
		MusicController.playDamageCharFX()
		OptionsController.dieCharacter()
		get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_body_entered(body):
	if body.name == "Character":
		next_scene_validator = true
