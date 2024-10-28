extends InteractableObject

@export var anim:AnimatedSprite2D

func _ready() -> void:
	super()
	gui_focus.closed.connect(end_interact)

func end_interact() -> void:
	super()
	match gui_focus.close():
		-1:
			return
		0:
			global.pathfinder.set_point_solid(map_position, true)
			anim.play_backwards("open")
			gui_interaction_priority = 2
		1:
			global.pathfinder.set_point_solid(map_position, false)
			anim.play("open")
			gui_interaction_priority = 1
