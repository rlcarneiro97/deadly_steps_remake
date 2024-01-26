extends Area2D

var next_scene = "res://scenes/parte_11.tscn"

@onready var run_truck = $RunTruck

func _status_truck() -> void:
	run_truck.play("run")
	await run_truck.animation_finished
	get_tree().change_scene_to_file(next_scene)

func _on_body_entered(body):
	if body.name == "Character" and get_parent().get_node("lever").get_disable_lever():
		body.visible = false
		_status_truck()
