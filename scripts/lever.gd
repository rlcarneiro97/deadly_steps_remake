extends Area2D

var is_lever_open := false
@export var is_lever_disable := false

@onready var acaoAlavancaAnim = $AcaoAlavanca

func _process(_delta):
	_lever_action()

func set_open_lever(action) -> void:
	self.is_lever_open = action
	
func get_disable_lever() -> bool:
	return self.is_lever_disable

func _lever_action() -> void:
	if self.is_lever_open and not self.is_lever_disable and Input.is_action_pressed("action"):
		self.is_lever_disable = true
		acaoAlavancaAnim.play("acao alavanca")
		get_parent().get_node("porta").set_is_door_open(true)
