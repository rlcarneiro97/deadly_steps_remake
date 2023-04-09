extends Node2D

@export var intro_mission_1_scene = preload("res://scenes/intro_mission_1.tscn")

func _process(_delta):
	skip()

func skip() -> void:
	
	if Input.is_action_just_pressed("continue"):
		get_tree().change_scene_to_packed(intro_mission_1_scene)
