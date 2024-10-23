extends Node2D

var Map: TileMapLayer
var Actions: int = 2
var speed: float = 100.0 # Speed of the player
var path = []# Array to hold the calculated path
var path_index: int = 0 # Current index in the path
var moving: bool = false # Movement flag

func _ready() -> void:
	global.pathfinder = AStarGrid2D.new()
	Map = get_parent().get_parent().get_child(0) # Adjust this as needed for clarity
	global.pathfinder.region = Map.get_used_rect()
	global.pathfinder.diagonal_mode = 1
	global.pathfinder.update()
	print(Map.get_used_rect())
	# Populate solid points based on tile data
	for I: Vector2i in Map.get_used_cells():
		if Map.get_cell_tile_data(I).get_custom_data("Col") == 0:
			global.pathfinder.set_point_solid(I)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			var cell_position = Map.local_to_map(get_global_mouse_position())
			if cell_position in Map.get_used_cells():
				if Map.get_cell_tile_data(cell_position).get_custom_data("Col") == 1:
					# Start moving to the new position
					calculate_path()
func calculate_path():
	if moving == true:
		return
	path = global.pathfinder.get_point_path(
	Map.local_to_map(position), 
	Map.local_to_map(get_global_mouse_position())
	)
	path = path.slice(1, min(Actions, path.size()))
	print(path)
	# Check if a valid path was found
	if path.size() > 0:
		moving = true
		path_index = 0
		print(path)

func _process(delta: float) -> void:
	if moving and path.size() > 0:
		var target_position = Map.map_to_local(path[path_index])
		global_position = global_position.move_toward(target_position, delta*speed)
		
		# Check if the player has reached the target position
		if position.distance_to(target_position) < speed * delta:
			position = target_position
			path_index += 1 # Move to the next point in the path
			
			# If reached the end of the path, stop moving
			if path_index >= path.size():
				moving = false
