extends Area2D

#enemy bullet

var bullet_velocity := 100
var bullet_direction := Vector2()
var bullet_damage := 1.0
var type_bullet := 0
var can_move := true

@onready var bullet_impact = $BulletImpact
@onready var bullet_damage_anim = $BulletDamageAnim

func _ready():
	bullet_impact.visible = false

func _physics_process(delta):
	self._change_bullet_type()
	self.bullet_movement(delta)

func set_direction(direction) -> void:
	self.bullet_direction = direction

func set_velocity(velocity) -> void:
	self.bullet_velocity = velocity
	
func set_bullet_damage(damage) -> void:
	self.bullet_damage = damage

func set_type_bullet(type_weapon) -> void:
	type_bullet = type_weapon

func get_bullet_damage() -> float:
	return self.bullet_damage

func _change_bullet_type() -> void:
	if type_bullet == 2:
		self.scale = Vector2(.7, .6)
	else:
		self.scale = Vector2(.6, .4)

func bullet_movement(delta) -> void:
	if not can_move:
		return
	else:
		self.translate(bullet_direction * bullet_velocity * delta)
	
func set_target_impact(target) -> void:
	if target == 1:
		self.bullet_impact.self_modulate = Color("#ffffff")
	elif target == 2:
		self.bullet_impact.self_modulate = Color("#f90000")
	else:
		self.bullet_impact.self_modulate = Color("#ffffff")
	
func apply_damage():
	self.can_move = false
	self.collision_layer = 0
	MusicController.play_bullet_impact_FX()
	bullet_damage_anim.play("BulletDamage")
	await bullet_damage_anim.animation_finished
	self.queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()

func _on_body_entered(_body):
	self.apply_damage()

func _on_area_entered(_area):
	self.apply_damage()
