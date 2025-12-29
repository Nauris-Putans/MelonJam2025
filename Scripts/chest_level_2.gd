extends Area2D

@export var mask_lvl2_anim: AnimationPlayer;
@onready var interactable: Area2D = $Interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	interactable.interact = _on_interact
	

func _on_interact():
	if animated_sprite_2d.frame == 0:
		animated_sprite_2d.play("open");
		GlobalScript.hasMask = true;
		GlobalScript.canWearMask = true;
		if mask_lvl2_anim:
			mask_lvl2_anim.play("lover");
		
		await mask_lvl2_anim.animation_finished;
		interactable.is_interactable = false;
		
