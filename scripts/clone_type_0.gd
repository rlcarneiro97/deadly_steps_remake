extends Area2D

var can_move := true
@export var enemy_speed := 220
@export var enemy_damage := .4
@export var enemy_health := 5.0
var direction := Vector2(-1, 0)
@onready var walk_anim = $WalkAnim
@onready var destroy_anim = $DestroyAnim

func _process(delta):
	self.attack_movement(delta)

func attack_movement(delta) -> void:
	if not can_move:
		return
	else:
		walk_anim.play("WalkCloneType0")
		self.translate(direction * enemy_speed * delta)

func apply_damage(bullet_damage) -> void:
	
	self.enemy_health -= bullet_damage
	MusicController.play_damage_enemy_FX()
	
	if enemy_health <= 0:
		self.destroy_object()
	
func destroy_object():
	self.can_move = false
	walk_anim.stop()
	self.collision_layer = 0
	destroy_anim.play("DestroyCloneType0")
	await destroy_anim.animation_finished
	MusicController.play_die_enemy_FX()
	self.queue_free()

func get_enemy_damage() -> float:
	return self.enemy_damage

func _on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.name == "Layer0" or body.name == "porta":
		self.can_move = false
		self.destroy_object()

func _on_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.is_in_group("bullet"):
		self.apply_damage(area.get_bullet_damage())
