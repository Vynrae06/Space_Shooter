extends CharacterBody2D

@export var PLAYER_INDEX: int
@export var MOVEMENT_SPEED: float = 666
@export var MOVEMENT_SPEED_LEFT: float = 250

var PROJECTILE_BASIC_SCENE: PackedScene = preload("res://player/projectile_basic.tscn")
var CAN_SHOOT: bool = true

func _ready():
	$AnimatedSprite2D.play("idle")

func _process(_delta):
	shoot_basic()

func _physics_process(_delta):
	move()
	move_and_slide()

func move():
	var input_x = Input.get_joy_axis(PLAYER_INDEX, JOY_AXIS_LEFT_X)
	var input_y = Input.get_joy_axis(PLAYER_INDEX, JOY_AXIS_LEFT_Y)
	var input_direction = Vector2(input_x, input_y)
	velocity = input_direction * MOVEMENT_SPEED

func shoot_basic():
	if Input.is_joy_button_pressed(PLAYER_INDEX, JOY_BUTTON_B) and CAN_SHOOT: 
		var spawned_projectile = PROJECTILE_BASIC_SCENE.instantiate() as Area2D
		spawned_projectile.global_position = $ShotInstantiateMarker.global_position
		$"../ProjectilesHolder".add_child(spawned_projectile)
		$ShotTimer.start()
		CAN_SHOOT = false

func shoot_special():
	if Input.is_joy_button_pressed(PLAYER_INDEX, JOY_BUTTON_RIGHT_SHOULDER):
		pass

func _on_shot_timer_timeout():
	CAN_SHOOT = true

func _on_death_area_entered(_area):
	queue_free()
