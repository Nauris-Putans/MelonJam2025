extends ParallaxLayer

@export var SPEED = -15;

func _process(delta: float) -> void:
		self.motion_offset.x += SPEED * delta;
