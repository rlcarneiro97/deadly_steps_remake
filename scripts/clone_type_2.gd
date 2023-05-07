extends Area2D

@onready var body = $Body
@onready var enemy_weapon = $EnemyWeapon

func _process(delta):
	_apply_direction()
	
	if Input.is_action_pressed("shoot"):
		enemy_weapon.shoot(delta)
	else:
		enemy_weapon.invisibleShootSprite()
	
func _apply_direction() -> void:
	
	if enemy_weapon.orientation():
		body.flip_h = true
	else:
		body.flip_h = false
