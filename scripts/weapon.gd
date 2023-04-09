extends Node2D

var vel = 800
var dir = Vector2()
var interval = .1
var last_shoot = 0
var precision = 0.05

@onready var weaponSprite = $WeaponSprite
@onready var marker = $Marker1
@onready var ejector = $Ejector1
#@onready var ejector2 = $Ejector2
var pre_bullet = preload("res://scenes/bullet.tscn")
var pre_sheel_casing = preload("res://scenes/sheel_casing.tscn")

func _physics_process(_delta):
	look_at(get_global_mouse_position())
	
func orientation() -> bool:

	if cos(rotation) < -0.01:
		weaponSprite.flip_v = true
		marker = $Marker2
		ejector = $Ejector2
		return true
	else:
		weaponSprite.flip_v = false
		marker = $Marker1
		ejector = $Ejector1
		return false

func shoot(delta) -> void:
	
	var vector = Vector2()
	
	if last_shoot <= 0:

		var sheelCasingInstance = pre_sheel_casing.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
		sheelCasingInstance.global_position = ejector.global_position
		sheelCasingInstance.rotation_degrees = rotation_degrees
		
		randomize()
		vector = Vector2(0, -1)
		vector.x += randf_range(-.5, .5)
		
		sheelCasingInstance.setDirection(vector)
		get_parent().get_parent().add_child(sheelCasingInstance)
		
#		---------------------------------------------------------------------------------------

		var bulletInstance = pre_bullet.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
		bulletInstance.global_position = marker.global_position
		bulletInstance.rotation_degrees = rotation_degrees
		
		randomize()
		vector.x = cos(rotation)
		vector.y = sin(rotation)
		vector.x += randf_range(-precision, precision)
		vector.y += randf_range(-precision, precision)
		
		bulletInstance.setDirection(vector)
		get_parent().get_parent().add_child(bulletInstance)
		last_shoot = interval
	
	if last_shoot > 0:
		last_shoot -= delta
