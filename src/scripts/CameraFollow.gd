extends Camera3D

@export var cameraPivotPath: NodePath
@export var objectToFollowPath: NodePath
@onready var cameraPivot = get_node(cameraPivotPath)
@onready var objectToFollow = get_node(objectToFollowPath)

@export var camAccel = 2 # Speed With Which The Camera3D Follows Up The Player (Not Need When Not using the `lerp` function

func _process(delta):
	cameraPivot.position = cameraPivot.position.lerp(objectToFollow.position, delta * camAccel)
	#cameraPivot.translation = self.translation # Un-Comment This & Comment Above if you want camera to just follow the player without any smooth follow-up
