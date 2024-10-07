extends Node
class_name CameraShaker2D

# Exported variables for customization
@export var shake_duration: float = 0.5
@export var shake_magnitude: float = 5.0
@export var shake_frequency: float = 0.05
@export var smooth_duration: float = 0.2 # Duration for smoothing the camera back to original position

# Internal variables
var is_shaking: bool = false
var original_position: Vector2
var restart_shake: bool = false

# Nodes
@export var camera : Camera2D

func _ready() -> void:
	randomize()

## TEMP FUNCTION - Need a global way of calling shake, please replace ##
func _process(delta: float) -> void:
	# Press space bar to start shaking
	if Input.is_action_just_pressed("ui_accept"):
		start_shake()

# Function to start the shake
func start_shake():
	if is_shaking:
		restart_shake = true
	else:
		is_shaking = true
		original_position = camera.offset
		shake()

# Function to apply the shake effect
func shake():
	var elapsed_time : float = 0.0
	var total_duration : float = shake_duration + smooth_duration
	var current_magnitude : float = shake_magnitude
	
	while elapsed_time < total_duration:
		if restart_shake:
			#Reset for a new shake
			elapsed_time = 0.0
			current_magnitude = shake_magnitude
			restart_shake = false
		elif elapsed_time < shake_duration:
			var progress : float = elapsed_time / shake_duration
			current_magnitude = shake_magnitude * (1 - progress) # Decrease magnitude over time
			var offset_x : float = randf_range(-current_magnitude, current_magnitude)
			var offset_y : float = randf_range(-current_magnitude, current_magnitude)
			camera.offset = original_position + Vector2(offset_x, offset_y)
		else:
			var smooth_elapsed_time : float = elapsed_time - shake_duration
			var smooth_progress : float = smooth_elapsed_time / smooth_duration
			camera.offset = camera.offset.lerp(Vector2.ZERO, smooth_progress)
		
		await get_tree().create_timer(shake_frequency).timeout
		elapsed_time += shake_frequency
	
	camera.offset = Vector2.ZERO
	is_shaking = false
