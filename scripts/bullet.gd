extends Area2D

var vel = 1000
var dir = Vector2()

func _physics_process(delta):
	translate(dir * vel * delta)

func setDir(direcao) -> void:
	dir = direcao

func setVel(bulletSpeed) -> void:
	vel = bulletSpeed

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(_body):
	queue_free()
