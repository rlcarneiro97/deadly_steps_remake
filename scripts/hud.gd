extends Control

const BASE_LIFE_BAR := 156
const PIXELS_BY_POINTS := .78

@onready var bar = $CanvasLayer/LifeBar/Life/Bar

func _ready():
	bar.size.x = self.get_life_character_in_pixels()

func _process(_delta):
	update_life_bar()
	pass
	
func get_life_character_in_pixels() -> float:
	return OptionsController.lifeCharacter * PIXELS_BY_POINTS

func update_life_bar() -> void:
	if bar.size.x > 0 or bar.size.x < self.BASE_LIFE_BAR:
		
		if get_life_character_in_pixels() < bar.size.x:
			bar.size.x -= (bar.size.x - get_life_character_in_pixels())
			
		elif get_life_character_in_pixels() > bar.size.x:
			bar.size.x += (get_life_character_in_pixels() - bar.size.x)

