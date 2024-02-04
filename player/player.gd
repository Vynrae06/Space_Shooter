extends CharacterBody2D
class_name Player

@export var PLAYER_INDEX: int
@export var MOVEMENT_SPEED: float = 666.0
@export var MOVEMENT_SPEED_LEFT: float = 250.0
@export var SPECIAL_CHARGE_MAX: int = 15
@export var SPECIAL_CHARGE_COST: int = 15
@export var SPECIAL_CHARGE_RATE: int = 1
@export var projectile_sprite_path_basic: String
@export var projectile_sprite_path_special: String
@export var shot_spawn_flash_sprite_path: String

var PROJECTILE_BASIC_SCENE: PackedScene = preload("res://player/player_projectile_basic.tscn")
var PROJECTILE_SPECIAL_SCENE: PackedScene = preload("res://player/player_projectile_special.tscn")

var CAN_SHOOT_BASIC: bool = true
var SHOOT_BASIC_CD_FREE: bool = true

var CAN_SHOOT_SPECIAL: bool = true
var SHOOT_SPECIAL_CD_FREE: bool = true
var SPECIAL_CHARGE: int = 0

var CAN_MOVE: bool = true

signal player_died

func _ready():
	get_parent().connect("fight_over", disable_player)
	$ShotSpawnFlash.texture = ResourceLoader.load(shot_spawn_flash_sprite_path)
	$ShotSpawnFlash.visible = false
	$PlaneAnimatedSprite.play("straight")

func _process(_delta):
	shoot_basic()
	shoot_special()
	
	$SpecialChargeBar.max_value = SPECIAL_CHARGE_MAX
	update_special_charge_bar()

func _physics_process(_delta):
	if CAN_MOVE:
		move()
		move_and_slide()
	
func update_special_charge_bar() -> void:
	$SpecialChargeBar.value = SPECIAL_CHARGE

func move():
	velocity = Vector2.ZERO
	
	var joy_input_x = Input.get_joy_axis(PLAYER_INDEX, JOY_AXIS_LEFT_X)
	var joy_input_y = Input.get_joy_axis(PLAYER_INDEX, JOY_AXIS_LEFT_Y)
	var joy_input_direction = Vector2(joy_input_x, joy_input_y)
	
	var keyboard_input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if joy_input_direction != Vector2.ZERO:
		velocity = joy_input_direction * MOVEMENT_SPEED
	elif keyboard_input_direction != Vector2.ZERO:
		velocity = keyboard_input_direction * MOVEMENT_SPEED

func shoot_basic():
	if (Input.is_joy_button_pressed(PLAYER_INDEX, JOY_BUTTON_B) or Input.is_action_pressed("shoot_basic")) and CAN_SHOOT_BASIC and SHOOT_BASIC_CD_FREE: 
		var spawned_projectile = PROJECTILE_BASIC_SCENE.instantiate() as Projectile
		spawned_projectile.set_sprite(projectile_sprite_path_basic)
		spawned_projectile.global_position = $ShotInstantiateMarker.global_position
		spawned_projectile.connect("damage_dealt_signal", damage_dealt_signal_received)
		$"../ProjectilesHolder".add_child(spawned_projectile)
		$ShotBasicTimer.start()
		$ShotSpawnFlashAnimationPlayer.play("shot_spawn_flash")
		SHOOT_BASIC_CD_FREE = false

func shoot_special():
	if (Input.is_joy_button_pressed(PLAYER_INDEX, JOY_BUTTON_RIGHT_SHOULDER) or Input.is_action_pressed("shoot_special")) and SPECIAL_CHARGE >= SPECIAL_CHARGE_COST and CAN_SHOOT_SPECIAL and SHOOT_SPECIAL_CD_FREE:
		var spawned_projectile = PROJECTILE_SPECIAL_SCENE.instantiate() as Projectile
		spawned_projectile.set_sprite(projectile_sprite_path_special)		
		spawned_projectile.global_position = $ShotInstantiateMarker.global_position
		$"../ProjectilesHolder".add_child(spawned_projectile)
		$ShotSpecialTimer.start()
		$ShotSpawnFlashAnimationPlayer.play("shot_spawn_flash")		
		SHOOT_SPECIAL_CD_FREE = false
		
		SPECIAL_CHARGE -= SPECIAL_CHARGE_COST
		update_special_charge_bar()
		$SpecialChargeBar/BlinkingLightAnimationPlayer.stop()
		$SpecialChargeBar/PointLight2D.energy = 0
		
func damage_dealt_signal_received():
	if SPECIAL_CHARGE < SPECIAL_CHARGE_MAX:
		SPECIAL_CHARGE += SPECIAL_CHARGE_RATE
		update_special_charge_bar()
		if SPECIAL_CHARGE == SPECIAL_CHARGE_MAX:
			$SpecialChargeBar/BlinkingLightAnimationPlayer.play("blinking_light")

func _on_shot_basic_timer_timeout():
	SHOOT_BASIC_CD_FREE = true

func _on_shot_special_timer_timeout():
	SHOOT_SPECIAL_CD_FREE = true

func _on_death_area_entered(_area):
	player_died.emit()
	queue_free()

func disable_player():
	CAN_MOVE = false
	CAN_SHOOT_BASIC = false
	CAN_SHOOT_SPECIAL = false
	get_node("DeathArea/DeathCollider").set_deferred("disabled", true)
