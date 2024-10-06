@tool
extends MeshInstance3D
@export var specular_override:float = -1.0:
	set(val):
		specular_override = val
		update_vals()
@export var met_override:float = -1.0:
	set(val):
		met_override = val
		update_vals()
@export var rough_override:float = -1.0:
	set(val):
		rough_override = val
		update_vals()

var is_ready = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#mesh is ArrayMesh
	mesh = mesh.duplicate()
	for i in range(0,mesh.get_surface_count()):
		mesh.surface_set_material(i,mesh.surface_get_material(i).duplicate())
		mesh.surface_get_material(i).cull_mode = BaseMaterial3D.CullMode.CULL_DISABLED
	is_ready = true
		
func update_vals():
	if is_ready:
		for i in range(0,mesh.get_surface_count()):
			if specular_override >= 0:
				mesh.surface_get_material(i).metallic_specular = specular_override
			if met_override >= 0:
				mesh.surface_get_material(i).metallic = met_override
			if rough_override >= 0:
				mesh.surface_get_material(i).roughness = rough_override
