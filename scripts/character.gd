extends CharacterBody2D

# variaveis da maquina de estados
enum {IDLE, RUN, JUMP, FALL, SHOOT, RUN_SHOOT, JUMP_SHOOT, FALL_SHOOT}
var enter_state = true
var current_state = IDLE

# coloquei como var para testar mecanicas de pulo, velocidados e gravidade variados
var speed = 250.0
var jump_force = -850.0
var gravity = 2000

# variaveis de damage
var damage_receive := 0
var is_in_damage := false

@onready var weapon = $Weapon
@onready var body = $Body
@onready var walkAnim = $WalkAnim
@onready var shootAnim = $ShootAnim
@onready var damageAnim = $DamageAnim
@onready var dieAnim = $DieAnim

func _physics_process(delta):
	
	match current_state:
		IDLE:
			_idle_state(delta)
		RUN:
			_run_state(delta)
		JUMP:
			_jump_state(delta)
		FALL:
			_fall_state(delta)
		SHOOT:
			_shoot_state(delta)
		RUN_SHOOT:
			_run_shoot_state(delta)
		JUMP_SHOOT:
			_jump_shoot_state(delta)
		FALL_SHOOT:
			_fall_shoot_state(delta)

	applyContinuosDamage()

#-------------------------------------------------------------------------------

#CHECK FUNCTIONS

func _check_idle_state() -> int:
	var new_state = current_state
	
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		new_state = RUN
	elif Input.is_action_pressed("shoot"):
		new_state = SHOOT
	elif Input.is_action_pressed("jump")  and is_on_floor():
		new_state = JUMP
		
	return new_state
	
func _check_run_state() -> int:
	var new_state = current_state

	if not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		new_state = IDLE
	elif Input.is_action_pressed("shoot"):
		new_state = RUN_SHOOT
	elif Input.is_action_pressed("jump") and is_on_floor():
		new_state = JUMP
		
	return new_state

func _check_jump_state() -> int:
	var new_state = current_state
		
	if velocity.y >= 0:
		new_state = FALL
	elif Input.is_action_pressed("shoot"):
		new_state = JUMP_SHOOT
	
	return new_state

func _check_fall_state() -> int:
	var new_state = current_state
	
	if is_on_floor():
		new_state = IDLE
	elif Input.is_action_pressed("shoot"):
		new_state = FALL_SHOOT
	
	return new_state

func _check_shoot_state() -> int:
	var new_state = current_state
	
	if Input.is_action_just_released("shoot"):
		new_state = IDLE
	elif Input.is_action_pressed("left") or Input.is_action_pressed("right") and Input.is_action_pressed("shoot"):
		new_state = RUN_SHOOT
	elif Input.is_action_pressed("jump"):
		new_state = JUMP
	
	return new_state
	
func _check_run_shoot_state() -> int:
	var new_state = current_state
	
	if Input.is_action_pressed("jump"):
#		caso especial em que o melhor a se fazer eh jogar no jump normal em vez do jump_shoot
		new_state = JUMP
	elif not Input.is_action_pressed("shoot"):
		new_state = RUN
	elif not Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		new_state = SHOOT
		
	return new_state
	
func _check_jump_shoot_state() -> int:
	var new_state = current_state
	
	if velocity.y >= 0:
		new_state = FALL_SHOOT
	elif Input.is_action_just_released("shoot"):
		new_state = FALL
	
	return new_state
	
func _check_fall_shoot_state() -> int:
	var new_state = current_state
	
	if is_on_floor():
		new_state = IDLE
	elif Input.is_action_just_released("shoot"):
		new_state = FALL
	
	return new_state
	
#-------------------------------------------------------------------------------

#STATES

func _idle_state(_delta) -> void:
	
	walkAnim.stop()
	shootAnim.stop()
	weapon.invisibleShootSprite()
	
	_remove_residual_movement()
	_apply_gravity(_delta)
	_apply_move_and_slide()
	_apply_direction()
	
	_set_state(_check_idle_state())
	
func _run_state(_delta) -> void:
	
	shootAnim.stop()
	weapon.invisibleShootSprite()
	
	walkAnim.play("Walk")
	_apply_gravity(_delta)
	_apply_movement()
	_apply_move_and_slide()
	_apply_direction()
	
	_set_state(_check_run_state())
	
func _jump_state(_delta) -> void:
	
	walkAnim.stop()
	shootAnim.stop()
	weapon.invisibleShootSprite()
	
	if enter_state:
		_apply_jump_force()
		enter_state = false

	_apply_gravity(_delta)
	_apply_movement()
	_apply_move_and_slide()
	_apply_direction()
	
	_set_state(_check_jump_state())

func _fall_state(_delta) -> void:

	walkAnim.stop()
	weapon.invisibleShootSprite()

	_apply_gravity(_delta)
	_apply_movement()
	_apply_move_and_slide()
	_apply_direction()
	
	_set_state(_check_fall_state())

func _shoot_state(_delta) -> void:

	walkAnim.stop()
	weapon.shoot(_delta)
	shootAnim.play("Shoot")
	
	_remove_residual_movement()
	_apply_gravity(_delta)
	_apply_move_and_slide()
	_apply_direction()
	
	_set_state(_check_shoot_state())

func _run_shoot_state(_delta) -> void:
	
	weapon.shoot(_delta)
	shootAnim.play("Shoot")
	
	walkAnim.play("Walk")
	_apply_gravity(_delta)
	_apply_movement()
	_apply_move_and_slide()
	_apply_direction()
	
	_set_state(_check_run_shoot_state())
	
func _jump_shoot_state(_delta) -> void:
	
	walkAnim.stop()
	weapon.shoot(_delta)
	shootAnim.play("Shoot")
	
	if enter_state:
		enter_state = false

	_apply_gravity(_delta)
	_apply_movement()
	_apply_move_and_slide()
	_apply_direction()
	
	_set_state(_check_jump_shoot_state())

func _fall_shoot_state(_delta) -> void:
	
	walkAnim.stop()
	weapon.shoot(_delta)
	shootAnim.play("Shoot")

	_apply_gravity(_delta)
	_apply_movement()
	_apply_move_and_slide()
	_apply_direction()
	
	_set_state(_check_fall_shoot_state())

#-------------------------------------------------------------------------------

#HELPERS

func _apply_gravity(_delta) -> void:
	velocity.y += gravity * _delta
	
func _apply_move_and_slide() -> void:
	move_and_slide()
	
func _apply_movement() -> void:

	var direction = Input.get_axis("left", "right")

	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

func _apply_direction() -> void:

	if weapon.orientation():
		body.flip_h = true
	else:
		body.flip_h = false

func _apply_jump_force() -> void:
	velocity.y = jump_force

func _remove_residual_movement() -> void:
	var direction = Input.get_axis("left", "right")
	velocity.x = direction * 0

func _set_state(new_state) -> void:
	if new_state != current_state:
		enter_state = true
	current_state = new_state

#-------------------------------------------------------------------------------

#OTHERS

func applyContinuosDamage():
	
	if self.is_in_damage and OptionsController.lifeCharacter > 0:
		OptionsController.update_life(-self.damage_receive)
		MusicController.playDamageCharFX()
		damageAnim.play("DamageAnim")
	
	if OptionsController.lifeCharacter <= 0:
		damageAnim.play("DieAnim")
		await damageAnim.animation_finished
		MusicController.playDieEnemyFX()
		OptionsController.dieCharacter()

func _on_hitbox_area_entered(area):
	if area.is_in_group("enemy_type_0") or area.is_in_group("enemy_type_1"):
		self.damage_receive = area.getEnemyDamage()
		self.is_in_damage = true
	if area.is_in_group("fully_heal"):
		if OptionsController.lifeCharacter < OptionsController.BASE_LIFE_CHARACTER:
			OptionsController.update_life(OptionsController.BASE_LIFE_CHARACTER - OptionsController.lifeCharacter)
			area.destroy()

func _on_hitbox_area_exited(area):
	if area.is_in_group("enemy_type_0") or area.is_in_group("enemy_type_1"):
		self.is_in_damage = false
