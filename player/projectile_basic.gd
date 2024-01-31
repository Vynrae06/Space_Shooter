extends Area2D
class_name ProjectileBasic

@export var SPEED: float = 1000
@export var DAMAGE: int = 1

func _ready():
	$SelfDestructTimer.start()

func _physics_process(delta):
	position += transform.x * SPEED * delta

func _on_self_destruct_timer_timeout():
	queue_free()

func _on_area_entered(_area):
	queue_free()
