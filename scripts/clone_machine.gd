extends StaticBody2D

var cloneMachineDamage := 13
@onready var destroyAnim = $DestroyAnim

#func _ready():
#	pass

#func _process(_delta):
#	pass
	
func applyDamage(bullet_damage):
	cloneMachineDamage -= bullet_damage
	print(cloneMachineDamage)
	
	if not cloneMachineDamage:
		self.destroyObject()
	
func destroyObject():
	destroyAnim.play("Destroy")
	await destroyAnim.animation_finished
	self.queue_free()
