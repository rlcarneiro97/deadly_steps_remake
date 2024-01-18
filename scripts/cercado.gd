@tool
extends Node2D

@export_enum("Esquerda", "Direita") var dir_cercado := 0:
	set(new_value):
		dir_cercado = new_value
		
		if Engine.is_editor_hint():
			queue_redraw()

@onready var sprite_cercado = $Sprite2D

func _draw():
	_change_dir_cercado()

func _process(_delta):
	if Engine.is_editor_hint():
		return

func _change_dir_cercado() -> void:
	if dir_cercado == 0:
		sprite_cercado.flip_h = false
	elif dir_cercado == 1:
		sprite_cercado.flip_h = true
