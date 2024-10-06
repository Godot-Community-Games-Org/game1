@tool
extends Node

@export var should_disable_backface_culling = false
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_children():
		if i is MeshInstance3D:
			i.mesh = i.mesh.duplicate()
			i.mesh.call("lightmap_unwrap",i.global_transform,64.0)
			for l in range(0, i.mesh.get_surface_count()):
				i.mesh.surface_set_material(l,i.mesh.surface_get_material(l).duplicate())
				if should_disable_backface_culling:
					i.mesh.surface_get_material(l).cull_mode = BaseMaterial3D.CullMode.CULL_DISABLED
				
