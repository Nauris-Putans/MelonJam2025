extends CharacterBody2D


const SPEED = 120.0
const JUMP_VELOCITY = -300.0

var is_interaction_enabled = false;
var is_in_mask_anim = false;
var interactible_type: String;
var is_mask_toggled = false;

@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
@onready var tile_map_layer_2: TileMapLayer = $"../TileMapLayer2_emo"
@onready var color_rect: ColorRect = $Camera2D/ColorRect

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() && !is_in_mask_anim:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if Input.is_action_just_pressed("interact") && is_interaction_enabled:
		print_debug("I am gay! but "+ interactible_type);
	
	if Input.is_action_just_pressed("toggle_mask"):
		is_mask_toggled = !is_mask_toggled;
		_toggle_overlay();
		
		print_debug("He is gay!");
	
	if direction > 0:
		animated_sprite_2d.flip_h = false;
	elif direction < 0:
		animated_sprite_2d.flip_h = true;
		
	if is_on_floor():
		if direction == 0:
			_idle();
		else:
			_walk();
	else:
		animated_sprite_2d.play("jump");
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _can_interact(type: String):
	is_interaction_enabled = true;
	interactible_type = type;

func _can_not_interact():
	is_interaction_enabled = false;
	interactible_type = "null";

func _idle():
	if is_mask_toggled:
		animated_sprite_2d.play("masked_idle");
	else:
		animated_sprite_2d.play("idle");

func _walk():
	if is_mask_toggled:
		animated_sprite_2d.play("masked_walk");
	else:
		animated_sprite_2d.play("walk");
		
func _toggle_overlay():
	is_in_mask_anim = true;
	var tween := create_tween();

	# Fade in (alpha 0 → 1)
	tween.tween_property(
		color_rect,
		"color:a",
		1.0,
		0.5
	)

	# Wait until fade-in is done
	await tween.finished

	# Toggle tile maps AFTER screen is dark
	if is_mask_toggled:
		tile_map_layer.hide();
		tile_map_layer_2.show();
		self.collision_mask = 2;
	else:
		tile_map_layer.show();
		tile_map_layer_2.hide();
		self.collision_mask = 1;

	# New tween for fade out
	var tween_out := create_tween()
	tween_out.tween_property(
		color_rect,
		"color:a",
		0.0,
		0.5
	)
	is_in_mask_anim = false;

	
