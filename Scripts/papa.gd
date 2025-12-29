extends CharacterBody2D

@onready var interactable: Area2D = $Interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $hello/AnimationPlayer

func _ready() -> void:
	interactable.interact = _on_interact
	

func _on_interact():
	if animated_sprite_2d.frame == 0:
		animated_sprite_2d.play("default");
		interactable.is_interactable = false;
		animation_player.play("new_animation");
		await get_tree().create_timer(7).timeout;
		animated_sprite_2d.flip_h = false;
		await get_tree().create_timer(2).timeout;
		await GlobalScript.toggleOvarlay.call();

		TransitionLayer.change_scene("res://Scenes/level-3.tscn");
