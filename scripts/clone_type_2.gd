extends Area2D

var enemy_health := 5.0
var is_loading = true

@onready var body = $Body
@onready var enemy_weapon = $EnemyWeapon
@onready var destroy_anim = $DestroyAnim

func _process(delta):
	
	_apply_direction()
	
#	substituir dps por IA que atira de tempos em tempos
#	if Input.is_action_pressed("shoot"):
#		enemy_weapon.shoot(delta)
#	else:
#		enemy_weapon.invisibleShootSprite()
	
	_clone_type_2_behavior(delta)
	
func _apply_direction() -> void:
	if enemy_weapon.orientation():
		body.flip_h = true
	else:
		body.flip_h = false

func applyDamage(bullet_damage) -> void:
	
	self.enemy_health -= bullet_damage
	MusicController.playDamageEnemyFX()
	
	if enemy_health <= 0:
		self.destroyObject()

func destroyObject():
	
	self.collision_layer = 0
	destroy_anim.play("DestroyCloneType2")
	await destroy_anim.animation_finished
	MusicController.playDieEnemyFX()
	self.queue_free()

func _clone_type_2_behavior(delta) -> void:
	
	if not is_loading:
		enemy_weapon.shoot(delta)
	elif is_loading:
		enemy_weapon.invisibleShootSprite()

func _on_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.is_in_group("bullet"):
		self.applyDamage(area.getBulletDamage())

func _on_timer_timeout():
	self.is_loading = not self.is_loading
