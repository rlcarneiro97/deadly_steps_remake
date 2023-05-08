extends Control

const BASE_LIFE_BAR := 156
#se alterar a quantidade de vida, divida a base_life_bar pela base_life_character
var PIXELS_BY_POINTS := .0

@onready var bar = $CanvasLayer/LifeBar/Life/Bar

func _ready():
	bar.size.x = self.get_life_character_in_pixels()
	PIXELS_BY_POINTS = generate_const_pixels_by_points()
	
func _process(_delta):
	update_life_bar()
	pass

func generate_const_pixels_by_points() -> float:
	return (BASE_LIFE_BAR / OptionsController.BASE_LIFE_CHARACTER)

func get_life_character_in_pixels() -> float:
	return OptionsController.lifeCharacter * PIXELS_BY_POINTS

func update_life_bar() -> void:
	if bar.size.x > 0 or bar.size.x < self.BASE_LIFE_BAR:
		
		if get_life_character_in_pixels() < bar.size.x:
			bar.size.x -= (bar.size.x - get_life_character_in_pixels())
			
		elif get_life_character_in_pixels() > bar.size.x:
			bar.size.x += (get_life_character_in_pixels() - bar.size.x)

