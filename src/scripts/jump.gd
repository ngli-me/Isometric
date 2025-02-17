extends Node

@export var jump_initial_impulse := 10.0
@export var gravity: = -30.0

var player: PlayerEntity
var character_controller: CharacterController
var snap

var gravityVec = Vector3()

func _ready() -> void:
	character_controller = owner
	player = character_controller.get_parent()

func _physics_process(delta: float) -> void:
	if (Input.is_action_just_pressed("mv_jump")):
		snap = Vector3.ZERO
		player.velocity.y = jump_initial_impulse
	
	# If I add more stuff to the character controller, this needs to be at the end of all of the 
	# _physics_process calls.
	# see: https://gamedev.stackexchange.com/questions/206461/whats-the-appropiate-way-to-achieve-composition-in-godot
	player.move_and_slide()


func enter(msg: = {}) -> void:
	player.velocity.y = jump_initial_impulse
