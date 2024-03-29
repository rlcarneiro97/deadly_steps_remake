extends Node2D

var BASE_LIFE_CHARACTER := 30.0
var life_character := 0.0
var current_weapon := 0
var scenario_name := "Parte_3"
var release_checkpoint := false
var menu_scene = preload("res://scenes/menu.tscn")
var data_file_path = "user://savegame.save"

func _ready():
	self.life_character = self.BASE_LIFE_CHARACTER

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
		if self.life_character > 0:
			self.life_character -= abs(new_value)
	elif sign(new_value) == 1:
		if self.life_character < self.BASE_LIFE_CHARACTER:
			self.life_character += abs(new_value)
	
func die_character() -> void:
	current_weapon = 0
	MusicController.stop_bg_music_mission()
	get_tree().change_scene_to_packed(menu_scene)
	#A linha abaixo reseta a vida do char para reiniciar o jogo
	self.life_character = self.BASE_LIFE_CHARACTER

func save(scenario, weapon) -> Dictionary:
	var dic_save = {
		"scenario_name": scenario,
		"weapon": weapon
	}
	return dic_save

func save_game(scenario, weapon_number) -> bool:
	var savegame = FileAccess.open(data_file_path, FileAccess.WRITE)
	savegame.store_string(JSON.stringify(save(scenario, weapon_number)))
	savegame.close()
	
	return true
	
func load_game() -> bool:
	if FileAccess.file_exists(data_file_path):
		var loadgame = FileAccess.open(data_file_path, FileAccess.READ)
		print(JSON.parse_string(loadgame.get_as_text()))
		var data = JSON.parse_string(loadgame.get_as_text())
		loadgame.close()
		
		self.scenario_name = data["scenario_name"]
		self.current_weapon = int(data["weapon"])
		self.release_checkpoint = true
		
		get_tree().change_scene_to_file("res://scenes/"+scenario_name.to_lower()+".tscn")
		return true
		
	return false
