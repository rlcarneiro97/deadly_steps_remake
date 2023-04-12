extends Area2D

var enemy_damage := 1.0
var enemy_velocity := 300
var enemy_health := 5.0
var direction := Vector2(-1, 0)
@onready var walkAnim = $WalkAnim
@onready var destroyAnim = $DestroyAnim

func _process(delta):
	self.attack(delta)

func attack(delta):
	walkAnim.play("WalkCloneType0")
	translate(direction * enemy_velocity * delta)

func applyDamage(bullet_damage):
	self.enemy_health -= bullet_damage

	if not enemy_health:
		self.destroyObject()
	
func destroyObject():
	self.collision_layer = 0
	destroyAnim.play("DestroyCloneType0")
	await destroyAnim.animation_finished
	self.queue_free()

func getEnemyDamage() -> float:
	return self.enemy_damage

func _on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.name == "TileMap":
		self.queue_free()
