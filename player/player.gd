extends CharacterBody2D

@export var MOVEMENT_SPEED: float = 666
@export var MOVEMENT_SPEED_LEFT: float = 250

var PROJECTILE_BASIC_SCENE: PackedScene = preload("res://player/projectile_basic.tscn")
var CAN_SHOOT: bool = true

func _ready():
	$AnimatedSprite2D.play("idle")

func _process(_delta):
	shoot()

func _physics_process(_delta):
	move()
	move_and_slide()

func move():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * MOVEMENT_SPEED

func shoot():
	if Input.is_action_pressed("shoot_normal") and CAN_SHOOT: 
		var spawned_projectile = PROJECTILE_BASIC_SCENE.instantiate() as Area2D
		spawned_projectile.global_position = $ShotInstantiateMarker.global_position
		$"../ProjectilesHolder".add_child(spawned_projectile)
		$ShotTimer.start()
		CAN_SHOOT = false

func _on_shot_timer_timeout():
	CAN_SHOOT = true

func _on_death_area_entered(area):
	queue_free()
