extends Control

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var settings: Node = $Settings

func _on_play_button_pressed() -> void:
	audio_stream_player_2d.play();
	TransitionLayer.change_scene("res://Scenes/intro.tscn")


func _on_setting_button_pressed() -> void:
	audio_stream_player_2d.play();
	settings.open_settings();


func _on_help_button_pressed() -> void:
	audio_stream_player_2d.play();
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	audio_stream_player_2d.play();
	get_tree().quit();
