extends Area2D

var status_lever := false
@export var disable_lever := false

@onready var acaoAlavancaAnim = $AcaoAlavanca

func _process(_delta):
	_verify_status_lever()

func set_status_lever(action_lever) -> int:
	self.status_lever = action_lever
	return status_lever

func _verify_status_lever() -> void:
	if self.status_lever and not disable_lever and Input.is_action_pressed("action"):
		self.disable_lever = true
		get_parent().get_node("porta").set_is_door_opened(true)
		acaoAlavancaAnim.play("acao alavanca")
