@tool
extends CollisionShape3D


func _ready():
	var new_shape: ConvexPolygonShape3D = shape.duplicate()
	var new_array = PackedVector3Array()
	new_array.resize(new_shape.points.size())
	for l in range(new_shape.points.size()):
		var i = new_shape.points[l]
		i.x *= scale.x
		i.y *= scale.y
		i.z *= scale.z
		new_array.set(l,i)
	new_shape.set_points(new_array)
	set_shape(new_shape)
	scale = Vector3(1.,1.,1.)
	
