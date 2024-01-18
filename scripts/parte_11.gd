extends Node2D

@export var menu_scene = load("res://scenes/menu.tscn")

func _process(_delta):
	skip()

func skip() -> void:
	if Input.is_action_just_pressed("continue"):
		MusicController.stop_bg_music_mission()
		get_tree().change_scene_to_packed(menu_scene)
