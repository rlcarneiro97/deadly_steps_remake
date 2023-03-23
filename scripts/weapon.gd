extends Node2D

var vel = 800
var dir = Vector2()
var interval = .0290
var last_shoot = 0
var precision = 0.08

@onready var weaponSprite = $WeaponSprite
@onready var marker = $Marker1
var pre_bullet = preload("res://scenes/bullet.tscn")

func _physics_process(_delta):
	look_at(get_global_mouse_position())
	
func orientation() -> bool:

	if cos(rotation) < -0.01:
		weaponSprite.flip_v = true
		marker = $Marker2
		return true
	else:
		weaponSprite.flip_v = false
		marker = $Marker1
		return false

func shoot(delta) -> void:
	
	var vetor = Vector2()
	
	if last_shoot <= 0:

		var bulletInstance = pre_bullet.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
		bulletInstance.global_position = marker.global_position
		bulletInstance.rotation_degrees = rotation_degrees
		
		randomize()
		vetor.x = cos(rotation)
		vetor.y = sin(rotation)
		vetor.x += randf_range(-precision, precision)
		vetor.y += randf_range(-precision, precision)
		
		bulletInstance.setDir(vetor)
		get_parent().get_parent().add_child(bulletInstance)
		last_shoot = interval
	
	if last_shoot > 0:
		last_shoot -= delta
