extends CharacterBody2D

@export var PLAYER_INDEX: int
@export var MOVEMENT_SPEED: float = 666.0
@export var MOVEMENT_SPEED_LEFT: float = 250.0
@export var SPECIAL_CHARGE_MAX: int = 100
@export var SPECIAL_CHARGE_COST: int = 20
@export var SPECIAL_CHARGE_RATE: int = 1

var PROJECTILE_BASIC_SCENE: PackedScene = preload("res://player/player_projectile_basic.tscn")
var PROJECTILE_SPECIAL_SCENE: PackedScene = preload("res://player/player_projectile_special.tscn")
var CAN_SHOOT_BASIC: bool = true
var CAN_SHOOT_SPECIAL: bool = true
var SPECIAL_CHARGE: int = 0

func _ready():
	$AnimatedSprite2D.play("idle")

func _process(_delta):
	shoot_basic()
	shoot_special()

func _physics_process(_delta):
	move()
	move_and_slide()

func move():
	var input_x = Input.get_joy_axis(PLAYER_INDEX, JOY_AXIS_LEFT_X)
	var input_y = Input.get_joy_axis(PLAYER_INDEX, JOY_AXIS_LEFT_Y)
	var input_direction = Vector2(input_x, input_y)
	velocity = input_direction * MOVEMENT_SPEED

func shoot_basic():
	if Input.is_joy_button_pressed(PLAYER_INDEX, JOY_BUTTON_B) and CAN_SHOOT_BASIC: 
		var spawned_projectile = PROJECTILE_BASIC_SCENE.instantiate() as Area2D
		spawned_projectile.global_position = $ShotInstantiateMarker.global_position
		spawned_projectile.connect("damage_dealt_signal", damage_dealt_signal_received)
		$"../ProjectilesHolder".add_child(spawned_projectile)
		$ShotBasicTimer.start()
		CAN_SHOOT_BASIC = false

func shoot_special():
	if Input.is_joy_button_pressed(PLAYER_INDEX, JOY_BUTTON_RIGHT_SHOULDER) and SPECIAL_CHARGE >= SPECIAL_CHARGE_COST and CAN_SHOOT_SPECIAL:
		var spawned_projectile = PROJECTILE_SPECIAL_SCENE.instantiate() as Area2D
		spawned_projectile.global_position = $ShotInstantiateMarker.global_position
		$"../ProjectilesHolder".add_child(spawned_projectile)
		$ShotSpecialTimer.start()
		CAN_SHOOT_SPECIAL = false
		SPECIAL_CHARGE -= SPECIAL_CHARGE_COST
		
func damage_dealt_signal_received():
	if SPECIAL_CHARGE < SPECIAL_CHARGE_MAX:
		SPECIAL_CHARGE += SPECIAL_CHARGE_RATE
	print(SPECIAL_CHARGE)
	
func _on_shot_special_timer_timeout():
	CAN_SHOOT_SPECIAL = true

func _on_shot_basic_timer_timeout():
	CAN_SHOOT_BASIC = true

func _on_death_area_entered(_area):
	queue_free()
