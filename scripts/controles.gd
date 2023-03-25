extends Node2D

@export var intro_mission_1_scene = preload("res://scenes/intro_mission_1.tscn")

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	skip()

func skip() -> void:
	
	if Input.is_action_just_pressed("continue"):
#		MusicController.stopBgMusicMenu()
#		MusicController.playBgMusicMission()
		get_tree().change_scene_to_packed(intro_mission_1_scene)
