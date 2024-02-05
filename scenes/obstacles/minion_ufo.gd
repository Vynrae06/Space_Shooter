extends ObstacleDestroyable
class_name MinionUFO

@export var SPEED: float
@export var FREQUENCY: float
@export var AMPLITUDE: float
var TIME: float = 0

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	position.x -= SPEED * delta
	position.y += cos(TIME * FREQUENCY) * AMPLITUDE * delta

func _process(delta):
	TIME+= delta
