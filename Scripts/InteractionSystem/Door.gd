extends InteractableObject
class_name InteractableDoor
@export var anim:AnimatedSprite2D
func interact() -> void:
	$Button/Control.visible = true
	$Button/Control.grab_focus()



func _on_control_closed(selected: int) -> void:
	$Button.grab_focus()
	match selected:
		-1:
			return
		0:
			global.pathfinder.set_point_solid(global.map.local_to_map(position), true)
			anim.play_backwards("open")
			gui_interaction_priority = 2
		1:
			global.pathfinder.set_point_solid(global.map.local_to_map(position), false)
			anim.play("open")
			gui_interaction_priority = 1
