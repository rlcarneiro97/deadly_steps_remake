extends Area2D

var is_truck_avaliable := false

var next_scene = "res://scenes/parte_11.tscn"

@onready var run_truck = $RunTruck

func _process(_delta):
	_status_truck()
	pass

func _status_truck() -> void:
	if is_truck_avaliable:
		$CollisionShape2D.disabled = true
		is_truck_avaliable = false
		run_truck.play("run")
		await run_truck.animation_finished
		get_tree().change_scene_to_file(next_scene)

func _on_body_entered(body):
	if body.name == "Character" and get_parent().get_node("lever").get_disable_lever():
		is_truck_avaliable = true
		body.visible = false
