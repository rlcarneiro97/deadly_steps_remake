extends Node2D

@onready var bgMusicMenu = $BgMusicMenu
@onready var bgMusicMission = $BgMusicMission

@onready var shootFX = $ShootFX
@onready var damageFX = $DamageFX
@onready var damageCharFX = $DamageCharFX
@onready var explodeFX = $ExplodeFX
@onready var damageEnemyFX = $DamageEnemyFX
@onready var dieEnemyFX = $DieEnemyFX

#-------------------------------------------------------------------------------
	
# BACKGROUND SOUNDS

func playBgMusicMenu():
	bgMusicMenu.play()
	
func playBgMusicMission():
	bgMusicMission.play()
	
func stopBgMusicMenu():
	bgMusicMenu.stop()
	
func stopBgMusicMission():
	bgMusicMission.stop()
	
#-------------------------------------------------------------------------------
	
# SOUND EFFECTS
	
func playShootFX():
	self.shootFX.play()
	
func playDamageFX():
	self.damageFX.play()
	
func playDamageCharFX():
	self.damageCharFX.play()
	await damageCharFX.finished
	
func playExplodeFX():
	self.explodeFX.play()
	
func playDamageEnemyFX():
	self.damageEnemyFX.play()
	
func playDieEnemyFX():
	self.dieEnemyFX.play()

#-------------------------------------------------------------------------------
	
# SIGNALS

func _on_bg_music_menu_finished():
	bgMusicMenu.play()

func _on_bg_music_mission_finished():
	bgMusicMission.play()
