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
@export var INVINCIBILITY_TIME: float

var PROJECTILE_BASIC_SCENE: PackedScene = preload("res://scenes/player/player_projectile_basic.tscn")
var PROJECTILE_SPECIAL_SCENE: PackedScene = preload("res://scenes/player/player_projectile_special.tscn")

var CAN_SHOOT_BASIC: bool = false
var SHOOT_BASIC_CD_FREE: bool = true

var CAN_SHOOT_SPECIAL: bool = false
var SHOOT_SPECIAL_CD_FREE: bool = true
var SPECIAL_CHARGE: int = 0

var CAN_MOVE: bool = false
var IS_ALIVE: bool = true

var SPECIAL_HUD_DISPLAYED_ONCE: bool = false

func _ready():
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
	if (Input.is_joy_button_pressed(PLAYER_INDEX, JOY_BUTTON_B) or Input.is_joy_button_pressed(PLAYER_INDEX, JOY_BUTTON_A) or Input.is_action_pressed("shoot_basic")) and CAN_SHOOT_BASIC and SHOOT_BASIC_CD_FREE: 
		var spawned_projectile = PROJECTILE_BASIC_SCENE.instantiate() as Projectile
		spawned_projectile.set_sprite(projectile_sprite_path_basic)
		spawned_projectile.global_position = $ShotInstantiateMarker.global_position
		spawned_projectile.connect("damage_dealt_signal", damage_dealt_signal_received)
		$"../ProjectilesHolder".add_child(spawned_projectile)
		$ShotBasicTimer.start()
		$ShotFlashAnimationPlayer.play("shot_spawn_flash")
		$ShotBasicSFX.play()
		SHOOT_BASIC_CD_FREE = false
		
		if $BasicAttackHUD.visible:
			hide_basic_attack_hud()

func shoot_special():
	if (Input.is_joy_button_pressed(PLAYER_INDEX, JOY_BUTTON_RIGHT_SHOULDER) or Input.is_joy_button_pressed(PLAYER_INDEX, JOY_BUTTON_LEFT_SHOULDER) or Input.is_action_pressed("shoot_special")) and SPECIAL_CHARGE >= SPECIAL_CHARGE_COST and CAN_SHOOT_SPECIAL and SHOOT_SPECIAL_CD_FREE:
		var spawned_projectile = PROJECTILE_SPECIAL_SCENE.instantiate() as Projectile
		spawned_projectile.set_sprite(projectile_sprite_path_special)		
		spawned_projectile.global_position = $ShotInstantiateMarker.global_position
		$"../ProjectilesHolder".add_child(spawned_projectile)
		$ShotSpecialTimer.start()
		$ShotFlashAnimationPlayer.play("shot_spawn_flash")
		$ShotSpecialSFX.play()
		SHOOT_SPECIAL_CD_FREE = false
		
		SPECIAL_CHARGE -= SPECIAL_CHARGE_COST
		update_special_charge_bar()
		$SpecialChargeBar/BlinkingLightAnimationPlayer.stop()
		$SpecialChargeBar/PointLight2D.energy = 0
		
		if $SpecialAttackHUD.visible:
			hide_special_attack_hud()
		
func damage_dealt_signal_received():
	if SPECIAL_CHARGE < SPECIAL_CHARGE_MAX:
		SPECIAL_CHARGE += SPECIAL_CHARGE_RATE
		update_special_charge_bar()
		if SPECIAL_CHARGE == SPECIAL_CHARGE_MAX:
			$SpecialChargeBar/BlinkingLightAnimationPlayer.play("blinking_light")
			
			if !SPECIAL_HUD_DISPLAYED_ONCE:
				SPECIAL_HUD_DISPLAYED_ONCE = true
				display_special_attack_hud()

func _on_shot_basic_timer_timeout():
	SHOOT_BASIC_CD_FREE = true

func _on_shot_special_timer_timeout():
	SHOOT_SPECIAL_CD_FREE = true

func _on_death_area_entered(area):
	if IS_ALIVE:
		IS_ALIVE = false
		Global.PLAYERS_ALIVE -= 1
		disable_player()
		$AnimationPlayer.play("bubble_help")
		if area.get_parent() is ObstacleDestroyable:
			area.get_parent().destroy_self()
		

func disable_player():
	CAN_MOVE = false
	CAN_SHOOT_BASIC = false
	CAN_SHOOT_SPECIAL = false
	get_node("DeathArea/DeathCollider").set_deferred("disabled", true)

func _on_revive_area_area_entered(area):
	if area != self and !IS_ALIVE :
		IS_ALIVE = true
		Global.PLAYERS_ALIVE += 1
		enable_player()
		$RevivedSFX.play()
		$AnimationPlayer.play("invincibility")
		await get_tree().create_timer(INVINCIBILITY_TIME).timeout
		get_node("DeathArea/DeathCollider").set_deferred("disabled", false)

func enable_player():
	CAN_MOVE = true
	CAN_SHOOT_BASIC = true
	CAN_SHOOT_SPECIAL = true

func display_basic_attack_hud():
	$BasicAttackHUD.visible = true
	$BasicAttackHUD.play("default")
	
func hide_basic_attack_hud():
	$BasicAttackHUD.visible = false
	$BasicAttackHUD.stop()

func display_special_attack_hud():
	$SpecialAttackHUD.visible = true
	$SpecialAttackHUD.play("default")

func hide_special_attack_hud():
	$SpecialAttackHUD.visible = false
	$SpecialAttackHUD.stop()
