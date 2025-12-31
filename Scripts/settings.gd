extends Node

@onready var control: Control = $Control
@onready var h_slider: HSlider = $Control/MarginContainer/Panel/MarginContainer/VBoxContainer/VBoxContainer/HSlider

func open_settings():
	var value = AudioServer.get_bus_volume_db(0);
	print(value);
	h_slider.set_value_no_signal(value);
	control.show();

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value);

func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, toggled_on);

func _on_quit_button_pressed() -> void:
	control.hide();
