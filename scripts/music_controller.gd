extends Node2D

@onready var bg_music_menu = $BgMusicMenu
@onready var bg_music_mission = $BgMusicMission

@onready var shoot_FX = $ShootFX
@onready var bullet_impact_FX = $BulletImpactFX
@onready var damage_clone_machine_FX = $DamageCloneMachineFX
@onready var damage_char_FX = $DamageCharFX
@onready var explode_FX = $ExplodeFX
@onready var damage_enemy_FX = $DamageEnemyFX
@onready var die_enemy_FX = $DieEnemyFX
@onready var heal_FX = $HealFX

#-------------------------------------------------------------------------------
	
# BACKGROUND SOUNDS

func play_bg_music_menu():
	bg_music_menu.play()
	
func play_bg_music_mission():
	bg_music_mission.play()
	
func stop_bg_music_menu():
	bg_music_menu.stop()
	
func stop_bg_music_mission():
	bg_music_mission.stop()
	
#-------------------------------------------------------------------------------
	
# SOUND EFFECTS
	
func play_shoot_FX():
	self.shoot_FX.play()
	
func play_bullet_impact_FX():
	self.bullet_impact_FX.play()
	
func play_damage_clone_machine_FX():
	self.damage_clone_machine_FX.play()
	
func play_damage_char_FX():
	self.damage_char_FX.play()
	await damage_char_FX.finished
	
func play_explode_FX():
	self.explode_FX.play()
	
func play_damage_enemy_FX():
	self.damage_enemy_FX.play()
	
func play_die_enemy_FX():
	self.die_enemy_FX.play()
	
func play_heal_FX():
	self.heal_FX.play()

#-------------------------------------------------------------------------------
	
# SIGNALS

func _on_bg_music_menu_finished():
	bg_music_menu.play()

func _on_bg_music_mission_finished():
	bg_music_mission.play()
