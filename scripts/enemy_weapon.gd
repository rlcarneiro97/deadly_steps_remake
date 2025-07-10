@tool
extends Node2D

@export_enum("M4A2", "Fama", "AK_45") var type_weapon := 0:
	set(new_value):
		type_weapon = new_value
		
		if type_weapon == 0:
			shooting_interval = .14
			bullet_damage = 1.0
		elif type_weapon == 1:
			shooting_interval = .09
			bullet_damage = .5
		elif type_weapon == 2:
			shooting_interval = .12
			bullet_damage = 2.0
		
		if Engine.is_editor_hint():
			queue_redraw()

#enemy weapon
var direction_vector := Vector2()
var bullet_velocity := 800
var bullet_damage := 1.0
var shooting_interval := .14
var last_shoot := 0.0
var shooting_precision := 0.02
var bullet_light_M4A2 := Vector2(1.5, 3)*1.0
var bullet_light_Fama := Vector2(1.5, 3)*1.5
var bullet_light_AK_45 := Vector2(1.5, 3)*2.0

@onready var weapon_sprite = $WeaponSprite
@onready var marker = $WeaponSprite/Marker1
@onready var ejector = $WeaponSprite/Ejector1
@onready var shoot_sprite = $WeaponSprite/Shoot1

var pre_enemy_bullet = preload("res://scenes/enemy_bullet.tscn")
var pre_sheel_casing = preload("res://scenes/sheel_casing.tscn")
var weapon_skins = [
	"res://assets/armas/M4A2_Enemy_Hand.png",
	"res://assets/armas/Fama_Enemy_Hand.png",
	"res://assets/armas/AK_45_Enemy_Hand.png"
]

func _draw():
	_change_type_weapon()

func _ready():
	update_current_weapon_data()

func _process(_delta):
	if Engine.is_editor_hint():
		return

func _physics_process(_delta):
	if not Engine.is_editor_hint():
		look_at(get_parent().get_parent().get_node("Character").get_global_position())

func orientation() -> bool:
	if cos(rotation) < -0.01:
		return true
	else:
		return false

func update_current_weapon_data():
	if type_weapon == 0:
		shoot_sprite.self_modulate = Color("#ffffff")
		shoot_sprite.scale = bullet_light_M4A2
		marker.position = Vector2(32, 8.5)
		shoot_sprite.position = Vector2(56, 7.5)
	if type_weapon == 1:
		shoot_sprite.self_modulate = Color("#ffff00")
		shoot_sprite.scale = bullet_light_Fama
		marker.position = Vector2(33, 2)
		shoot_sprite.position = Vector2(68.5, 0)
	if type_weapon == 2:
		shoot_sprite.self_modulate = Color("#ff5100")
		shoot_sprite.scale = bullet_light_AK_45
		marker.position = Vector2(33, 7.5)
		shoot_sprite.position = Vector2(80, 3)

func shoot(delta) -> void:
	
	self.invisible_shoot_sprite()
	
	if last_shoot <= 0:
		var sheel_casing_instance = pre_sheel_casing.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
		sheel_casing_instance.global_position = ejector.global_position
		sheel_casing_instance.rotation_degrees = rotation_degrees
		
		randomize()
		direction_vector = Vector2(0, -1)
		direction_vector.x += randf_range(-.5, .5)
		
		sheel_casing_instance.set_direction(direction_vector)
		get_parent().get_parent().add_child(sheel_casing_instance)
		
#		---------------------------------------------------------------------------------------

		var enemy_bullet_instance = pre_enemy_bullet.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
		self.shoot_sprite.visible = true
		MusicController.play_shoot_FX(type_weapon)
		enemy_bullet_instance.global_position = marker.global_position
		enemy_bullet_instance.rotation_degrees = rotation_degrees
		
		randomize()
		direction_vector.x = cos(rotation)
		direction_vector.y = sin(rotation)
		direction_vector.x += randf_range(-shooting_precision, shooting_precision)
		direction_vector.y += randf_range(-shooting_precision, shooting_precision)
		
		enemy_bullet_instance.set_direction(self.direction_vector)
		enemy_bullet_instance.set_velocity(self.bullet_velocity)
		enemy_bullet_instance.set_bullet_damage(self.bullet_damage)
		enemy_bullet_instance.set_type_bullet(self.type_weapon)
		get_parent().get_parent().add_child(enemy_bullet_instance)
		last_shoot = shooting_interval
		
	if last_shoot > 0:
		last_shoot -= delta

func set_type_weapon(type) -> void:
	self.type_weapon = type

func _change_type_weapon() -> void:
	
	if type_weapon == 0:
		weapon_sprite.texture = load(weapon_skins[0])
	elif type_weapon == 1:
		weapon_sprite.texture = load(weapon_skins[1])
	elif type_weapon == 2:
		weapon_sprite.texture = load(weapon_skins[2])
		
	update_current_weapon_data()

func invisible_shoot_sprite() -> void:
	shoot_sprite.visible = false
