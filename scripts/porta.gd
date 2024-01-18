extends StaticBody2D

var is_door_opened := false
@export var disable_door := false
@export_enum("Tipo 1", "Tipo 2") var type_porta_baixo := 0:
	set(new_value):
		type_porta_baixo = new_value

@onready var open_door_anim = $open_door
@onready var collision_shape = $CollisionShape2D

func _process(_delta):
	_door_open_action()
	_verify_type_porta_baixo(type_porta_baixo)

func set_is_door_opened(status) -> int:
	MusicController.play_lever_FX()
	self.is_door_opened = status
	return self.is_door_opened
	
func _verify_type_porta_baixo(type_porta) -> void:
	if type_porta == 0:
		$porta_baixo.visible = false
		$porta_baixo2.visible = true
	elif type_porta == 1:
		$porta_baixo.visible = true
		$porta_baixo2.visible = false
	
func _door_open_action():
	if is_door_opened:
		open_door_anim.play("open_door")
		await open_door_anim.animation_finished
		self.disable_door = true
		queue_free()
