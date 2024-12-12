extends CharacterBody3D

const ACCEL_DEFAULT = 10 # Normal Acceleration
const ACCEL_AIR = 1 # Acceleration in Air

@onready var accel = ACCEL_DEFAULT
var speed = 10
var gravity = 20
var jump = 8
var mouseSensi = 0.1
var rotationSpeed = 4
var snap

var direction = Vector3()
#var velocity = Vector3()
var gravityVec = Vector3()
var movement = Vector3()

var mouseCaptured = true

func captureMouse():
	if (mouseCaptured == true):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # Hide Mouse Pointer
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) # Show Mouse Pointer

func _ready():
	captureMouse();

func _input(event):
	if (event is InputEventMouseMotion and mouseCaptured == true):
		self.rotate_y(deg_to_rad(-event.relative.x * mouseSensi))

func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		mouseCaptured = !mouseCaptured
		captureMouse()

func _physics_process(delta):
	direction = Vector3.ZERO
	var hRot = global_transform.basis.get_euler().y # Horizontal Rotation

	# Forward & Backward Input
	var fInput = Input.get_action_strength("mvBackward") - Input.get_action_strength("mvForward")
	var hInput = Input.get_action_strength("mvRight") - Input.get_action_strength("mvLeft")

	if (mouseCaptured == true):
		if (Input.is_action_pressed("rotLeft")):
			self.rotate_y(deg_to_rad(rotationSpeed))
		elif (Input.is_action_pressed("rotRight")):
			self.rotate_y(deg_to_rad(-rotationSpeed))
	else:
		fInput = 0
		hInput = 0

	direction = Vector3(hInput, 0, fInput).rotated(Vector3.UP, hRot).normalized()

	if is_on_floor():
		snap = -get_floor_normal()
		accel = ACCEL_DEFAULT
		gravityVec = Vector3.ZERO
	else:
		snap = Vector3.DOWN
		accel = ACCEL_AIR
		gravityVec += Vector3.DOWN * gravity * delta
		
	if Input.is_action_just_pressed("mvJump") and is_on_floor() and mouseCaptured == true:
		snap = Vector3.ZERO
		gravityVec = Vector3.UP * jump

	# Move
	velocity = velocity.lerp(direction * speed, accel * delta)
	movement = velocity + gravityVec

	# warning-ignore:return_value_discarded
	set_velocity(movement)
	# TODOConverter3To4 looks that snap in Godot 4 is float, not vector like in Godot 3 - previous value `snap`
	set_up_direction(Vector3.UP)
	move_and_slide()
