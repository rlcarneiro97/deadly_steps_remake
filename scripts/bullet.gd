extends Area2D

var vel = 800
var direction = Vector2()

var BULLET_DAMAGE := 1

func _physics_process(delta):
	translate(direction * vel * delta)

func setDirection(dir) -> void:
	self.direction = dir

func setVel(bulletSpeed) -> void:
	vel = bulletSpeed

func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()

func _on_body_entered(body):
	if body.name == "CloneMachine":
		body.applyDamage(BULLET_DAMAGE)
	queue_free()
