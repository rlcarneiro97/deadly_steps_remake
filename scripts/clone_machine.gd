extends StaticBody2D

var clone_machine_damage := 13.0

@onready var destroy_anim = $DestroyAnim
@onready var timer = $Timer
@onready var marker = $Marker2D
var pre_enemy = preload("res://scenes/clone_type_0.tscn")

func instance_enemy() -> void:
	var enemy_instance = pre_enemy.instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	enemy_instance.global_position = marker.global_position
	get_parent().add_child(enemy_instance)
	
	if timer.wait_time == 0.1:
		timer.one_shot = false
		timer.wait_time = 4
		timer.start()

func apply_damage(bullet_damage):
	MusicController.play_damage_clone_machine_FX()
	clone_machine_damage -= bullet_damage
	
	if clone_machine_damage <= 0:
		self.destroy_object()

func destroy_object():
	MusicController.play_explode_FX()
	self.collision_layer = 0
	destroy_anim.play("CloneMachineDestroy")
	await destroy_anim.animation_finished
	self.queue_free()

func _on_timer_timeout():
	self.instance_enemy()
