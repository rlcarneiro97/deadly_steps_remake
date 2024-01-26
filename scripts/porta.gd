extends StaticBody2D

var is_door_open := false
@export var is_door_disable := false
@export_enum("Tipo 1", "Tipo 2") var type_porta_baixo := 0:
	set(new_value):
		type_porta_baixo = new_value

@onready var open_door_anim = $open_door
@onready var collision_shape = $CollisionShape2D

func _process(_delta):
	_door_action()
	_check_type_porta_baixo(type_porta_baixo)

func set_is_door_open(status) -> int:
	MusicController.play_lever_FX()
	self.is_door_open = status
	return self.is_door_open
	
func _check_type_porta_baixo(type_porta) -> void:
	if type_porta == 0:
		$porta_baixo.visible = false
		$porta_baixo2.visible = true
	elif type_porta == 1:
		$porta_baixo.visible = true
		$porta_baixo2.visible = false
	
func _door_action():
	if self.is_door_open:
		open_door_anim.play("open_door")
		await open_door_anim.animation_finished
		self.is_door_disable = true
		queue_free()
