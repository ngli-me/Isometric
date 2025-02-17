extends Node
class_name CharacterController

var _parent:PlayerEntity
var _player_input

func _enter_tree():
	_parent = get_parent()
	# var hotspot:Vector2 = Vector2(16,16) if cursor_arrow else Vector2.ZERO
	# Input.set_custom_mouse_cursor(cursor_arrow, Input.CURSOR_ARROW, hotspot)
	# Input.set_custom_mouse_cursor(cursor_hand, Input.CURSOR_POINTING_HAND, hotspot)
	await _parent.ready
