extends Area2D

var bullet_velocity := 100
var bullet_direction := Vector2()
var bullet_damage := 1.0

func _physics_process(delta):
	translate(bullet_direction * bullet_velocity * delta)

func setDirection(direction) -> void:
	self.bullet_direction = direction

func setVelocity(velocity) -> void:
	self.bullet_velocity = velocity
	
func setBulletDamage(damage) -> void:
	self.bullet_damage = damage

func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()

func _on_body_entered(body):
	if body.name == "CloneMachine":
		body.applyDamage(bullet_damage)
	self.queue_free()

func _on_area_entered(area):
	if area.is_in_group("enemy"):
		area.applyDamage(bullet_damage)
		self.queue_free()

#	self.queue_free()
