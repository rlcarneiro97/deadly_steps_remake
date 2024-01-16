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
@onready var lever_FX = $LeverFX
@onready var change_weapon_FX = $ChangeWeaponFX

var weapon_sounds = [
	"res://sounds/fx/M4A1 556 Single MP3.mp3",
	"res://sounds/fx/Famas 762x39 Single MP3.mp3",
	"res://sounds/fx/AK45 762x54r Single MP3.mp3"
]

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
	
func play_shoot_FX(type_weapon):
	if type_weapon == 0:
		shoot_FX.stream = load(weapon_sounds[0])
		shoot_FX.volume_db = 12
		shoot_FX.pitch_scale = .9
	elif type_weapon == 1:
		shoot_FX.stream = load(weapon_sounds[1])
		shoot_FX.volume_db = 15
		shoot_FX.pitch_scale = 1
	elif type_weapon == 2:
		shoot_FX.stream = load(weapon_sounds[2])
		shoot_FX.volume_db = 15
		shoot_FX.pitch_scale = .6
	
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
	
func play_lever_FX():
	self.lever_FX.play()
	
func play_change_weapon_FX():
	self.change_weapon_FX.play()

#-------------------------------------------------------------------------------
	
# SIGNALS

func _on_bg_music_menu_finished():
	bg_music_menu.play()

func _on_bg_music_mission_finished():
	bg_music_mission.play()
