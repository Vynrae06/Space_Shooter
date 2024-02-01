extends Area2D
class_name ProjectileBasic

signal damage_dealt_signal

@export var SPEED: float = 1000
@export var DAMAGE: int = 1

func _ready():
	$SelfDestructTimer.start()

func _physics_process(delta):
	position.x += SPEED * delta

func _on_self_destruct_timer_timeout():
	queue_free()

func _on_area_entered(_area: Area2D):
	if _area is HurtBoxComponent:
		damage_dealt_signal.emit()
	queue_free()
