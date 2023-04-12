extends StaticBody2D

var cloneMachineDamage := 13.0

@onready var destroyAnim = $DestroyAnim
@onready var timer = $Timer
@onready var marker = $Marker2D
var pre_enemy = preload("res://scenes/clone_type_0.tscn")

func _ready():
	self.instanceEnemy()

func instanceEnemy() -> void:
	var enemyInstance = pre_enemy.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	enemyInstance.global_position = marker.global_position
	get_parent().get_parent().add_child(enemyInstance)
	
func applyDamage(bullet_damage):
	
	cloneMachineDamage -= bullet_damage
	
	if not cloneMachineDamage:
		self.destroyObject()
	
func destroyObject():
	self.collision_layer = 0
	destroyAnim.play("CloneMachineDestroy")
	await destroyAnim.animation_finished
	self.queue_free()

func _on_timer_timeout():
	self.instanceEnemy()
