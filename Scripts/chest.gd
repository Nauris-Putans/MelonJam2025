extends Area2D

@export var mask_tutorial_anim: AnimationPlayer;
@onready var interactable: Area2D = $Interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	interactable.interact = _on_interact
	

func _on_interact():
	if animated_sprite_2d.frame == 0:
		animated_sprite_2d.play("open");
		GlobalScript.hasMask = true;
		GlobalScript.canWearMask = true;
		if mask_tutorial_anim:
			mask_tutorial_anim.play("mask_tutorial");
		
		interactable.is_interactable = false;
		
