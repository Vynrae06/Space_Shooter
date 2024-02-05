extends ParallaxBackground

@export var STARS_SPEED: float = 50

func _process(delta):
	$StarsFront.motion_offset.x -= delta * STARS_SPEED
	$StarsMiddle.motion_offset.x -= delta * STARS_SPEED * 0.66
	$StarsBack.motion_offset.x -= delta * STARS_SPEED * 0.33
