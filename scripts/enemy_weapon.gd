extends Node2D

var bullet_velocity := 800
var bullet_damage := 1.0
var direction_vector := Vector2()
# M4A1 = .12 e dano = 1.0
# FAMAS = .05 e dano .5
# AK45 = .13 e dano 2.0
var shooting_interval := .12
var last_shoot := 0.0
var shooting_precision := 0.02

@onready var weaponSprite = $WeaponSprite
@onready var marker = $Marker1
@onready var ejector = $Ejector1
@onready var shoot_sprite = $Shoot1

var pre_bullet = preload("res://scenes/bullet.tscn")
var pre_sheel_casing = preload("res://scenes/sheel_casing.tscn")

func _physics_process(_delta):
	look_at(get_parent().get_parent().find_child("Character").global_position)

func orientation() -> bool:

	if cos(rotation) < -0.01:
		weaponSprite.flip_v = true
		marker = $Marker2
		ejector = $Ejector2
		shoot_sprite = $Shoot2
		return true
	else:
		weaponSprite.flip_v = false
		marker = $Marker1
		ejector = $Ejector1
		shoot_sprite = $Shoot1
		return false

func shoot(delta) -> void:
	
	self.invisibleShootSprite()
	
	if last_shoot <= 0:
		var sheelCasingInstance = pre_sheel_casing.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
		sheelCasingInstance.global_position = ejector.global_position
		sheelCasingInstance.rotation_degrees = rotation_degrees
		
		randomize()
		direction_vector = Vector2(0, -1)
		direction_vector.x += randf_range(-.5, .5)
		
		sheelCasingInstance.setDirection(direction_vector)
		get_parent().get_parent().add_child(sheelCasingInstance)
		
#		---------------------------------------------------------------------------------------

		var bulletInstance = pre_bullet.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
		self.shoot_sprite.visible = true
		MusicController.playShootFX()
		bulletInstance.global_position = marker.global_position
		bulletInstance.rotation_degrees = rotation_degrees
		
		randomize()
		direction_vector.x = cos(rotation)
		direction_vector.y = sin(rotation)
		direction_vector.x += randf_range(-shooting_precision, shooting_precision)
		direction_vector.y += randf_range(-shooting_precision, shooting_precision)
		
		bulletInstance.setDirection(self.direction_vector)
		bulletInstance.setVelocity(self.bullet_velocity)
		bulletInstance.setBulletDamage(self.bullet_damage)
		get_parent().get_parent().add_child(bulletInstance)
		last_shoot = shooting_interval
		
	if last_shoot > 0:
		last_shoot -= delta

func invisibleShootSprite() -> void:
	$Shoot1.visible = false
	$Shoot2.visible = false
