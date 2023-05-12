@tool
extends Area2D

@export_enum("CLONE_TYPE_1", "CLONE_TYPE_3", "CLONE_TYPE_5") var type_clone := 0:
	set(new_value):
		type_clone = new_value
		
		if type_clone == 0:
			enemy_health = 3.0
		elif type_clone == 1:
			enemy_health = 4.0
		elif type_clone == 2:
			enemy_health = 4.0
			
		if Engine.is_editor_hint():
			queue_redraw()

@export var enemy_health := 3.0
var enemy_damage := .4

@onready var body = $Body
@onready var left_hand = $LeftHand
@onready var right_hand = $RightHand
@onready var destroy_anim = $DestroyAnim
@onready var idle_anim = $IdleAnim

func _draw():
	_change_type_clone()

func _ready():
	idle_anim.play("IdleAnim")

func _process(_delta):
	if Engine.is_editor_hint():
		return

func _change_type_clone() -> void:
	
	if type_clone == 0:
			body.self_modulate = Color("#6cf6c3")
			left_hand.self_modulate = Color("#6cf6c3")
			right_hand.self_modulate = Color("#6cf6c3")
	elif type_clone == 1:
			body.self_modulate = Color("#6ca3f6")
			left_hand.self_modulate = Color("#6ca3f6")
			right_hand.self_modulate = Color("#6ca3f6")
	elif type_clone == 2:
			body.self_modulate = Color("#ff575a")
			left_hand.self_modulate = Color("#ff575a")
			right_hand.self_modulate = Color("#ff575a")

func get_enemy_damage() -> float:
	return self.enemy_damage

func apply_damage(bullet_damage) -> void:
	
	self.enemy_health -= bullet_damage
	MusicController.play_damage_enemy_FX()
	
	if enemy_health <= 0:
		self.destroy_object()
	
func destroy_object():
	self.collision_layer = 0
	
	if type_clone == 0:
		destroy_anim.play("DestroyCloneType1")
	elif type_clone == 1:
		destroy_anim.play("DestroyCloneType3")
	elif type_clone == 2:
		destroy_anim.play("DestroyCloneType5")
		
	await destroy_anim.animation_finished
	MusicController.play_die_enemy_FX()
	self.queue_free()

func _on_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.is_in_group("bullet"):
		self.apply_damage(area.get_bullet_damage())
