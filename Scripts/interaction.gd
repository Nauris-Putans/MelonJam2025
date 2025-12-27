extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var is_interactible = false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") && is_interactible:
		animated_sprite_2d.play("open");
		



func _on_body_entered(body: Node2D) -> void:
	is_interactible = true;


func _on_body_exited(body: Node2D) -> void:
	is_interactible = false;
