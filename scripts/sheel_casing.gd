extends RigidBody2D

var ejection_force := 250
var direction := Vector2()

func _ready():
	apply_physics_effect()

func setDirection(dir) -> void:
	self.direction = dir

func apply_physics_effect() -> void:
	self.apply_impulse(direction * ejection_force)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
