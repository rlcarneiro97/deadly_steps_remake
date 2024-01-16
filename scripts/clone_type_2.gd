@tool
extends Area2D

@export_enum("CLONE_TYPE_2", "CLONE_TYPE_4", "JAY BARNLE") var type_clone := 0:
	set(new_value):
		type_clone = new_value
		
		if type_clone == 0:
			enemy_health = 5.0
		elif type_clone == 1:
			enemy_health = 4.0
		elif type_clone == 2:
			enemy_health = 8.0
		
		if Engine.is_editor_hint():
			queue_redraw()

@export_enum("M4A2", "Fama", "AK_45") var type_weapon := 0:
	set(new_value):
		type_weapon = new_value
		
		if Engine.is_editor_hint():
			queue_redraw()

@export var enemy_health := 5.0
var is_loading = true

@onready var body = $Body
@onready var left_hand = $LeftHand
@onready var right_hand = $RightHand
@onready var left_foot = $LeftFoot
@onready var right_foot = $RightFoot
@onready var arrow = $Arrow
@onready var enemy_weapon = $EnemyWeapon
@onready var destroy_anim = $DestroyAnim
@onready var idle_anim = $IdleAnim

func _draw():
	_change_type_clone()
	_change_weapon(type_weapon)
	
func _process(delta):
	if Engine.is_editor_hint():
		return
	
	_apply_direction()
	_clone_type_2_behavior(delta)

func _change_type_clone() -> void:
	
	if type_clone == 0:
			left_hand.visible = false
			right_hand.visible = false
			left_foot.visible = true
			right_foot.visible = true
			arrow.visible = false
			idle_anim.stop()
			
	elif type_clone == 1:
			left_hand.visible = true
			right_hand.visible = true
			left_foot.visible = false
			right_foot.visible = false
			arrow.visible = false
			idle_anim.play("IdleAnim")
			
	elif type_clone == 2:
		left_hand.visible = false
		right_hand.visible = false
		left_foot.visible = true
		right_foot.visible = true
		arrow.visible = true
		idle_anim.stop()

func _change_weapon(type) -> void:
	enemy_weapon.set_type_weapon(type)

func _apply_direction() -> void:
	if enemy_weapon.orientation():
		body.flip_h = true
	else:
		body.flip_h = false

func apply_damage(bullet_damage) -> void:
	
	self.enemy_health -= bullet_damage
	MusicController.play_damage_enemy_FX()
	
	if enemy_health <= 0:
		self.destroy_object()

func destroy_object():
	
	self.collision_layer = 0
	
	if type_clone == 0:
		destroy_anim.play("DestroyCloneType2")
	elif type_clone == 1:
		destroy_anim.play("DestroyCloneType4")
	elif type_clone == 2:
		destroy_anim.play("DestroyCloneType2")
		get_parent().get_node("porta").set_is_door_opened(true)
		
	await destroy_anim.animation_finished
	MusicController.play_die_enemy_FX()
	self.queue_free()

func _clone_type_2_behavior(delta) -> void:
	if not is_loading:
		enemy_weapon.shoot(delta)
	elif is_loading:
		enemy_weapon.invisible_shoot_sprite()

func _on_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.is_in_group("bullet"):
		self.apply_damage(area.get_bullet_damage())

func _on_timer_timeout():
	self.is_loading = not self.is_loading
