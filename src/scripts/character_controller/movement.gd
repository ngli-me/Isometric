extends Node

@export var acceleration:= 50
@export var gravity: = -30.0
@export var max_speed: = 15.0
@export var snap_length := 0.5
@export var do_stop_on_slope := true

var player: PlayerEntity
var character_controller: CharacterController
var _move_direction := Vector3.ZERO
var _player_input := Vector3.ZERO
var _is_directing := true
var velocity: Vector3:
	get:
		return player.velocity
	set(value):
		player.velocity = value

func _ready() -> void:
	character_controller = owner
	player = character_controller.get_parent()

func _physics_process(delta: float) -> void:
	_update_player_input()
	
	_move_direction.x = _player_input.x
	_move_direction.z = _player_input.z
	
	_update_velocity(delta)
	player.floor_snap_length = snap_length
	player.floor_stop_on_slope = do_stop_on_slope

func _update_player_input():
	var input = Input.get_vector("mv_west_rel", "mv_east_rel", "mv_north_rel", "mv_south_rel")
	_player_input = Vector3(input.x, 0, input.y)
	
	# align input with the camera 
	_player_input = player.camera.global_transform.basis * (_player_input)
	_player_input.y = 0
	# remove the following if you want character to be slower with how much you push the joystick
	# _player_input = _player_input.normalized()
	
func _update_velocity(delta: float):
	var y_velocity := velocity.y
	velocity.y = 0.0
	velocity = velocity.lerp(_move_direction * max_speed, acceleration * delta)
	
	velocity.y = y_velocity + gravity * delta # preserve y
