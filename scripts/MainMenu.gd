extends Node2D

func _on_Quit_Button_pressed():
	get_tree().quit(0)

func _on_Credits_Button_pressed():
	assert(get_tree().change_scene("res://scenes/credits.tscn") == 0, "Error while switching to scene credits")

func _on_Options_Button_pressed():
	pass # Replace with function body.

func _on_NewGame_Button_pressed():
	assert(get_tree().change_scene("res://scenes/TestLevel.tscn") == 0, "Error while loading level")
