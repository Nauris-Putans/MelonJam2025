extends Control


func _on_play_button_pressed() -> void:
	TransitionLayer.change_scene("res://Scenes/intro.tscn")


func _on_setting_button_pressed() -> void:
	pass # Replace with function body.


func _on_help_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit();
