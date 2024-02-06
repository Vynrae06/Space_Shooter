extends Area2D
class_name Projectile

signal damage_dealt_signal

@export var SPEED: float = 1000
@export var DAMAGE: int = 1
var LAZER_IMPACT_ANIMATION = preload("res://scenes/player/lazer_impact_animation.tscn")

func _ready():
	$SelfDestructTimer.start()

func _physics_process(delta):
	position.x += SPEED * delta

func _on_self_destruct_timer_timeout():
	queue_free()

func _on_area_entered(_area: Area2D):
	if _area is HurtBoxComponent:
		damage_dealt_signal.emit()
		var lazer_impact_animation_instance = LAZER_IMPACT_ANIMATION.instantiate()
		get_parent().add_child(lazer_impact_animation_instance)
		lazer_impact_animation_instance.global_position = position
		
	queue_free()

func set_sprite(path: String):
	$Sprite2D.texture = ResourceLoader.load(path)
