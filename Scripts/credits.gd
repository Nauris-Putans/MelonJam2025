extends Node

@onready var control: Control = $Control

func open_credits():
	control.show();
	
func _on_quit_button_pressed() -> void:
	control.hide();
