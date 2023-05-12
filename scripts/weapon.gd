extends Node2D

#weapon

var bullet_velocity := 800
var bullet_damage := 1.0
var direction_vector := Vector2()
# M4A1 = .12 e dano = 1.0
# FAMAS = .05 e dano .5
# AK45 = .13 e dano 2.0
var shooting_interval := .14
var last_shoot := 0.0
var shooting_precision := 0.02

@onready var weapon_sprite = $WeaponSprite
@onready var marker = $Marker1
@onready var ejector = $Ejector1
@onready var shoot_sprite = $Shoot1

var pre_bullet = preload("res://scenes/bullet.tscn")
var pre_sheel_casing = preload("res://scenes/sheel_casing.tscn")

func _physics_process(_delta):
	look_at(get_global_mouse_position())
	
func orientation() -> bool:

	if cos(rotation) < -0.01:
		weapon_sprite.flip_v = true
		marker = $Marker2
		ejector = $Ejector2
		shoot_sprite = $Shoot2
		return true
	else:
		weapon_sprite.flip_v = false
		marker = $Marker1
		ejector = $Ejector1
		shoot_sprite = $Shoot1
		return false

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

		var bullet_instance = pre_bullet.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
		self.shoot_sprite.visible = true
		MusicController.play_shoot_FX()
		bullet_instance.global_position = marker.global_position
		bullet_instance.rotation_degrees = rotation_degrees
		
		randomize()
		direction_vector.x = cos(rotation)
		direction_vector.y = sin(rotation)
		direction_vector.x += randf_range(-shooting_precision, shooting_precision)
		direction_vector.y += randf_range(-shooting_precision, shooting_precision)
		
		bullet_instance.set_direction(self.direction_vector)
		bullet_instance.set_velocity(self.bullet_velocity)
		bullet_instance.set_bullet_damage(self.bullet_damage)
		get_parent().get_parent().add_child(bullet_instance)
		last_shoot = shooting_interval
		
	if last_shoot > 0:
		last_shoot -= delta

func invisible_shoot_sprite() -> void:
	$Shoot1.visible = false
	$Shoot2.visible = false
