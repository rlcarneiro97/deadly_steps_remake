@tool
extends Area2D

@export_enum("Fama", "AK_45") var type_weapon := 0:
	set(new_value):
		type_weapon = new_value

		if Engine.is_editor_hint():
			queue_redraw()

@onready var sprite_weapon = $SpriteWeapon

var weapon_skins = [
	"res://assets/armas/Fama.png",
	"res://assets/armas/AK_45.png"
]

func _draw():
	_change_type_weapon()

func _process(_delta):
	if Engine.is_editor_hint():
		return

func get_type_weapon() -> int:
	return type_weapon+1

func destroy() -> void:
	MusicController.play_change_weapon_FX()
	self.queue_free()

func _change_type_weapon() -> void:
	if type_weapon == 0:
		sprite_weapon.texture = load(weapon_skins[0])
	elif type_weapon == 1:
		sprite_weapon.texture = load(weapon_skins[1])
