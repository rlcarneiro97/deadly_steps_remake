extends Node2D

@export var mission_scene = load("res://scenes/parte_1.tscn")

func _process(_delta):
	skip()

func skip() -> void:
	
	if Input.is_action_just_pressed("continue"):
		
		MusicController.stopBgMusicMenu()
		MusicController.playBgMusicMission()
		get_tree().change_scene_to_packed(mission_scene)
