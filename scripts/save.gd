extends Area2D

var is_in_savepoint := false
@onready var character

func _process(_delta):
	_verify_save_game()

func _on_body_entered(body):
	if body.name == "Character":
		is_in_savepoint = true
		self.character = body

func _on_body_exited(body):
	if body.name == "Character":
		is_in_savepoint = false

func _verify_save_game() -> void:
	if is_in_savepoint and Input.is_action_just_pressed("action"):
		$CanvasLayer.visible = true
		get_tree().paused = true

func _on_save_button_pressed():
	$CanvasLayer.visible = false
	OptionsController.save_game(get_parent().name, character.get_node("Weapon").get_type_weapon())
	$CanvasLayer2.visible = true

func _on_cancel_button_pressed():
	get_tree().paused = false
	$CanvasLayer.visible = false

func _on_confirm_button_pressed():
	get_tree().paused = false
	$CanvasLayer2.visible = false
