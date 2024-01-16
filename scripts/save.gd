extends Area2D

func _process(_delta):
	pass

func _on_body_entered(body):
	if body.name == "Character":
		OptionsController.save_game(get_parent().name, true, body.get_node("Weapon").get_type_weapon())
