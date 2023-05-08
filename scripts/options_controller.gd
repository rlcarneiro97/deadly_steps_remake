extends Node2D

var BASE_LIFE_CHARACTER := 30.0
var lifeCharacter := 0.0
var menu_scene = preload("res://scenes/menu.tscn")

func _ready():
	self.lifeCharacter = self.BASE_LIFE_CHARACTER

func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		exit_game()
	if Input.is_action_just_pressed("reload_scene"):
		reload_game()

func exit_game() -> void:
	get_tree().quit()
	
func reload_game() -> void:
	get_tree().reload_current_scene()
	
func update_life(new_value) -> void:
	
	if sign(new_value) == -1:
		if self.lifeCharacter > 0:
			self.lifeCharacter -= abs(new_value)
	elif sign(new_value) == 1:
		if self.lifeCharacter < self.BASE_LIFE_CHARACTER:
			self.lifeCharacter += abs(new_value)
	
func dieCharacter() -> void:
	MusicController.stopBgMusicMission()
	get_tree().change_scene_to_packed(menu_scene)
	#A linha abaixo reseta a vida do char para reiniciar o jogo
	self.lifeCharacter = self.BASE_LIFE_CHARACTER
	
func saveGame() -> void:
	pass
	
func loadGame() -> void:
	pass
