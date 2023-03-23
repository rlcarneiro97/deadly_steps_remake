extends Node2D

@onready var bgMusicMenu = $BgMusicMenu
@onready var bgMusicMission = $BgMusicMission

func playBgMusicMenu():
	bgMusicMenu.play()
	
func playBgMusicMission():
	bgMusicMission.play()
	
func stopBgMusicMenu():
	bgMusicMenu.stop()
	
func stopBgMusicMission():
	bgMusicMission.stop()

func _on_bg_music_menu_finished():
	bgMusicMenu.play()

func _on_bg_music_mission_finished():
	bgMusicMission.play()
