extends Area2D

var can_move := true
var enemy_damage := .4
var enemy_velocity := 250
var enemy_health := 5.0
var direction := Vector2(-1, 0)
@onready var walkAnim = $WalkAnim
@onready var destroyAnim = $DestroyAnim

func _process(delta):
	self.attackMovement(delta)

func attackMovement(delta) -> void:
	if not can_move:
		return
	else:
		walkAnim.play("WalkCloneType0")
		self.translate(direction * enemy_velocity * delta)

func applyDamage(bullet_damage) -> void:
	
	self.enemy_health -= bullet_damage
	MusicController.playDamageEnemyFX()
	
	if enemy_health <= 0:
		self.destroyObject()
	
func destroyObject():
	self.can_move = false
	walkAnim.stop()
	self.collision_layer = 0
	destroyAnim.play("DestroyCloneType0")
	await destroyAnim.animation_finished
	MusicController.playDieEnemyFX()
	self.queue_free()

func getEnemyDamage() -> float:
	return self.enemy_damage

func _on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.name == "TileMap":
		self.can_move = false
		self.destroyObject()
#		MusicController.playDieEnemyFX()
#		self.queue_free()

func _on_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.is_in_group("bullet"):
		self.applyDamage(area.getBulletDamage())
