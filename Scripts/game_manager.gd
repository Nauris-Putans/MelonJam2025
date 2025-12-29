extends Node
	
	
signal toggle_overlay_requested(on_finished: Callable)

var is_in_mask_anim = false;
@export var is_mask_toggled = false;

var UI_profile: AnimatedSprite2D;
@onready var color_rect: ColorRect = $Game/Player/Camera2D/ColorRect
@onready var player: CharacterBody2D = $Game/Player
@onready var tile_map_layer: Node2D 
@onready var tile_map_layer_2: Node2D
@onready var parallax_background_2: ParallaxBackground 
@onready var parallax_background: ParallaxBackground 
	

var map1pos := Vector2(0, 0);
var map2pos := Vector2(0, 0);

func _ready() -> void:
	map1pos = tile_map_layer.position;
	map2pos = tile_map_layer_2.position;
	
	GlobalScript.toggleOvarlay = _bring_fadein;
	toggle_overlay_requested.connect(_on_toggle_overlay_requested)
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
	if Input.is_action_just_pressed("toggle_mask") && GlobalScript.canWearMask:
		is_mask_toggled = !is_mask_toggled;
		_update_ui();
		_toggle_overlay();

func _update_ui():
	pass
		
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
		parallax_background_2.show();
		parallax_background.hide();
		if UI_profile != null:
			UI_profile.play("Masked_face");
		player.collision_mask = 2;
	else:
		tile_map_layer.show();
		tile_map_layer_2.hide();
		parallax_background_2.hide();
		parallax_background.show();
		
		if UI_profile != null:
			UI_profile.play("default");
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

func _on_toggle_overlay_requested(on_finished: Callable) -> void:
	if is_in_mask_anim:
		return

	is_mask_toggled = !is_mask_toggled
	await _bring_fadein();

	if on_finished.is_valid():
		on_finished.call()

func _bring_fadein() -> void:
	is_in_mask_anim = true

	var tween := create_tween()
	tween.tween_property(color_rect, "color:a", 1.0, 0.5)
	await tween.finished
	
	is_in_mask_anim = false
