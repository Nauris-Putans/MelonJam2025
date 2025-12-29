extends "res://Scripts/game_manager.gd"

@export var profile: AnimatedSprite2D;
@onready var memory_world: Node2D = $Game/MemoryWorld
@onready var memory_world_parallax_background_2: ParallaxBackground = $Game/MemoryWorld/ParallaxBackground2
@onready var destroyed_world: Node2D = $Game/EmoWorld
@onready var destroyed_world_parallax_background: ParallaxBackground = $Game/EmoWorld/ParallaxBackground
@onready var settings: Node = $CanvasLayer/Settings


func _ready() -> void:
	tile_map_layer = destroyed_world
	tile_map_layer_2 = memory_world
	parallax_background_2 = memory_world_parallax_background_2
	parallax_background = destroyed_world_parallax_background
	UI_profile = profile;


func _on_setting_button_pressed() -> void:
	settings.open_settings();
