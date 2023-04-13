extends Area2D

var bullet_velocity := 100
var bullet_direction := Vector2()
var bullet_damage := 1.0
var can_move := true

@onready var bulletSprite = $Sprite2D
@onready var bulletImpact = $BulletImpact
@onready var bulletDamageAnim = $BulletDamageAnim

func _ready():
	bulletImpact.visible = false

func _physics_process(delta):
	self.bulletMovement(delta)

func setDirection(direction) -> void:
	self.bullet_direction = direction

func setVelocity(velocity) -> void:
	self.bullet_velocity = velocity
	
func setBulletDamage(damage) -> void:
	self.bullet_damage = damage
	
func bulletMovement(delta) -> void:
	if not can_move:
		return
	else:
		self.translate(bullet_direction * bullet_velocity * delta)
	
func setTargetImpact(target) -> void:
	if target == 1:
		self.bulletImpact.self_modulate = Color("#ffffff")
	elif target == 2:
		self.bulletImpact.self_modulate = Color("#f90000")
	else:
		self.bulletImpact.self_modulate = Color("#ffffff")
	
func applyDamage():
	self.can_move = false
	bulletDamageAnim.play("BulletDamage")
	await bulletDamageAnim.animation_finished
	self.queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()

func _on_body_entered(body):
	if body.name == "CloneMachine":
		self.setTargetImpact(1)
		body.applyDamage(bullet_damage)
	self.applyDamage()

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		self.setTargetImpact(2)
		area.applyDamage(bullet_damage)
	self.applyDamage()
