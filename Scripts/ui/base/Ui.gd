extends Control
class_name UI

# UI Class:
# A Base UI class to contain common UI features within the game such as:
# - viewport Text Reizing (currently requires text size override to be on.).
# - Unknown.

#region font resizing options
# Export Settings
@export_group("FontResize")
@export_enum("none", "Width", "Height", "Both") var formula_calculation: int = 0  # Setting for how to resize fonts

# viewport base size.
@onready var base_size: Vector2 = Vector2(
	ProjectSettings.get_setting("display/window/size/viewport_width"), 
	ProjectSettings.get_setting("display/window/size/viewport_height")
)

# Dictionary to hold nodes with font size overrides
var font_nodes: Dictionary = {}  
#endregion

func _ready() -> void:
	# Store font size and node
	for I: Node in extend.get_all_Children(self):
		if I.has_theme_font_size_override("font_size"):
			font_nodes[I] = I.get("theme_override_font_sizes/font_size")
	
	get_tree().get_root().size_changed.connect(font_resize)
	font_resize()

func font_resize() -> void:
	var viewport_size = get_viewport().size
	for I: Node in font_nodes.keys():
		var Formula: float = 1.0

		match formula_calculation:
			1:  # Resize based on width
				Formula = viewport_size.x / base_size.x
			2:  # Resize based on height
				Formula = viewport_size.y / base_size.y
			3:  # Resize based on both width and height
				Formula = (viewport_size.x / base_size.x + viewport_size.y / base_size.y) / 2.0
		
		# Apply the new font size to the node
		I.add_theme_font_size_override("font_size", font_nodes[I] * Formula)
