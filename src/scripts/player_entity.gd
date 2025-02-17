class_name PlayerEntity
extends CharacterBody3D

@onready var camera:Camera3D = $CamPivot/Camera3D
@onready var camera_pivot:Node3D = $CamPivot

var mouseCaptured = true

func captureMouse():
	if (mouseCaptured == true):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # Hide Mouse Pointer
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) # Show Mouse Pointer

func _ready():
	captureMouse();

func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		mouseCaptured = !mouseCaptured
		captureMouse()
