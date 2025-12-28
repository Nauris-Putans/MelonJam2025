extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -440.0
var is_mask_toggled = false;
var is_grabing = false;

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var grab_hand_raycast: RayCast2D = $grabHandRaycast
@onready var grab_check_raycast: RayCast2D = $grabCheckRaycast

func _physics_process(delta: float) -> void:
	_check_ledge_grab();
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() || is_grabing):
		is_grabing = false;
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
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
		_jump();
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

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
		
func _jump():
	if is_mask_toggled:
		animated_sprite_2d.play("masked_jump");
	else:
		animated_sprite_2d.play("jump");

func toggle_mask():
	is_mask_toggled = !is_mask_toggled;

func _check_ledge_grab():
	var is_falling = velocity.y >= 0;
	var check_hand = not grab_hand_raycast.is_colliding();
	var check_grab_height = grab_check_raycast.is_colliding();
	
	var can_grab = is_falling && check_hand && check_grab_height && not is_grabing && is_on_wall_only();
	
	if can_grab:
		is_grabing = true;
		animated_sprite_2d.play("grabing_ledge");
	
