extends Node3D

const CAMERA_ANGLE: float = 1.57

var _parent:PlayerEntity
var mouseSensi = 0.005

var rotate = false
var target: float
var smooth = false

func _ready() -> void:
	_parent = get_parent()
	await _parent.ready

func _input(event):
	if (event.is_action_pressed("cam_rot") and _parent.mouseCaptured == true):
		rotate = true
		smooth = false
	if (event.is_action_released("cam_rot")):
		rotate = false
		smooth = true
		target = snapped(_parent.global_rotation.y, CAMERA_ANGLE)
	if (event is InputEventMouseMotion and rotate):
		_parent.rotate_y(-event.relative.x * mouseSensi)

func _process(delta: float):
	if smooth:
		_parent.global_rotation.y = move_toward(_parent.global_rotation.y, target, delta)
		if _parent.global_rotation.y == target:
			smooth = false
		
