extends Area2D

var enemy_damage := .4
var enemy_health := 3.0

@onready var destroyAnim = $DestroyAnim
@onready var idleAnim = $IdleAnim

func _ready():
	idleAnim.play("IdleAnim")

func getEnemyDamage() -> float:
	return self.enemy_damage

func applyDamage(bullet_damage) -> void:
	
	self.enemy_health -= bullet_damage
	MusicController.playDamageEnemyFX()
	
	if enemy_health <= 0:
		self.destroyObject()
	
func destroyObject():
	self.collision_layer = 0
	destroyAnim.play("DestroyCloneType1")
	await destroyAnim.animation_finished
	MusicController.playDieEnemyFX()
	self.queue_free()

func _on_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.is_in_group("bullet"):
		self.applyDamage(area.getBulletDamage())
