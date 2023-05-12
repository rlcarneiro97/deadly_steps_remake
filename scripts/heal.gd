extends Area2D

@onready var idle_heal_anim = $IdleHealAnim

func _ready():
	idle_heal_anim.play("IdleHealAnim")

func destroy() -> void:
	MusicController.play_heal_FX()
	self.queue_free()
