extends ParallaxBackground

@export var STARS_SPEED: float = 50

func _process(delta):
	$Stars.motion_offset.x -= delta * STARS_SPEED
