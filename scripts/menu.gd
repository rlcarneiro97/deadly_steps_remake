extends Node2D

@onready var play_button = $PlayButton
@onready var load_button = $LoadButton
@onready var quit_button = $QuitButton
@onready var menu = $Menu

@export var control_scene = preload("res://scenes/controls.tscn")

func _ready():
	play_button.flat = true
	load_button.flat = true
	quit_button.flat = true
	
	MusicController.play_bg_music_menu()  

# efeitos de botao
func _on_play_button_mouse_entered():
	play_button.flat = false

func _on_play_button_mouse_exited():
	play_button.flat = true

func _on_load_button_mouse_entered():
	load_button.flat = false

func _on_load_button_mouse_exited():
	load_button.flat = true

func _on_quit_button_mouse_entered():
	quit_button.flat = false
	
func _on_quit_button_mouse_exited():
	quit_button.flat = true
	
# fim

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(control_scene)

func _on_quit_button_pressed():
	OptionsController.exit_game()
