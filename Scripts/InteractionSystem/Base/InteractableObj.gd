extends Node2D
class_name InteractableObject
## Represents an interactive object within the game world, designed for objects that 
## the player can interact with when within a certain range. This class manages interaction 
## priorities, GUI visibility, and detection radius, allowing for flexible and layered 
## interactions with multiple objects.

# --- Exported Properties ---
@export var is_blocking: bool = true            ## Determines if this object blocks grid cell movement

@export_group("GUI", "gui")
@export var gui_interaction_priority: int = 0   ## Priority level for object selection
@export var gui_detection_radius: int = 2       ## Radius within which player can interact
@export var gui_button: Button                  ## GUI element for interaction display

@onready var map_position = global.map.local_to_map(position)

# --- Signals ---
signal interaction_started

# --- Built-in Callbacks ---
func _ready() -> void:
	# Initialize the object's solid state in the pathfinder grid if pathfinder and map are set up.
	if global.pathfinder and global.map:
		global.pathfinder.set_point_solid(global.map.local_to_map(position), is_blocking)
	else:
		push_error("Pathfinder or map not initialized.")
	global.player_moved.connect(_player_moved)

func _player_moved(player_position:Vector2i):
	# Check if the player is within detection range
	var is_within_radius := (player_position - map_position).length() < gui_detection_radius
	
	# Determine if GUI should be hidden based on priority
	var should_hide_gui := global.player.selected_object and global.player.selected_object != self and global.player.selected_object.gui_interaction_priority >= gui_interaction_priority
	
	if is_within_radius:
		# Handle GUI visibility and player selection
		if should_hide_gui:
			gui_button.visible = false
			return

		gui_button.grab_focus()
		global.player.selected_object = self
		gui_button.visible = true
	else:
		# Clear selection if the player moves out of range
		if global.player.selected_object == self:
			global.player.selected_object = null
		gui_button.visible = false

# --- Custom Methods ---
func interact() -> void:
	interaction_started.emit()
	# Placeholder for custom interaction behavior
	pass
