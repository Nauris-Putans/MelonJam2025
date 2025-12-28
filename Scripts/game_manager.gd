extends Node
	
var is_in_mask_anim = false;
@export var is_mask_toggled = false;

@onready var color_rect: ColorRect = $Game/Player/Camera2D/ColorRect
@onready var player: CharacterBody2D = $Game/Player
@onready var tile_map_layer: Node2D = $Game/EmoWorld
@onready var tile_map_layer_2: Node2D = $Game/MemoryWorld


var map1pos := Vector2(0, 0);
var map2pos := Vector2(0, 0);

func _ready() -> void:
	map1pos = tile_map_layer.position;
	map2pos = tile_map_layer_2.position;

	_update_maps();

func _update_maps() -> void:
	var offscreen_x := -100000;

	if is_mask_toggled:
		tile_map_layer.position = Vector2(offscreen_x, map1pos.y);
		tile_map_layer_2.position = map2pos;
	else:
		tile_map_layer.position = map1pos;
		tile_map_layer_2.position = Vector2(offscreen_x, map2pos.y);


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_mask"):
		is_mask_toggled = !is_mask_toggled;
		_toggle_overlay();

	
		
func _toggle_overlay():
	is_in_mask_anim = true;
	var tween := create_tween();
	
	tween.tween_property(
		color_rect,
		"color:a",
		1.0,
		0.5
	)

	await tween.finished
	
	if is_mask_toggled:
		tile_map_layer.hide();
		tile_map_layer_2.show();
		player.collision_mask = 2;
	else:
		tile_map_layer.show();
		tile_map_layer_2.hide();
		player.collision_mask = 1;
	
	_update_maps();
	player.toggle_mask();

	var tween_out := create_tween()
	tween_out.tween_property(
		color_rect,
		"color:a",
		0.0,
		0.5
	)
	is_in_mask_anim = false;
