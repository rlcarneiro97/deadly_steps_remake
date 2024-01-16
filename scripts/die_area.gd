extends Area2D

var next_scene_validator := false

func _process(_delta):
	skip()

func skip() -> void:
	
	if next_scene_validator:
		next_scene_validator = false
		MusicController.play_damage_char_FX()
		OptionsController.die_character()

func _on_body_entered(body):
	if body.name == "Character":
		next_scene_validator = true
