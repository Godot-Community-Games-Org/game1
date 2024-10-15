@tool #Allows the functions to be called by other tool scripts. Will be useful later.
class_name UtilityFunctions

## UtilityFunctions class:
## a class containing static functions for global use.

#Author: ChaoticTechSupport
static func get_all_Children(root_node, stop_class = null) -> Array[Node]: ## Gets all of the parents children (grand children, great grand children, ect)
	var nodes: Array[Node] = []
	for node in root_node.get_children():
		nodes.append(node)
		if node.get_child_count() > 0 and node != stop_class:
			nodes += get_all_Children(node, stop_class)
	return nodes

#Both of the following functions rely heavily on matrix/linear algebra. For a quick overview, see here: https://docs.godotengine.org/en/stable/tutorials/math/matrices_and_transforms.html
#Author: StrawberrySmoothieDev (Smoothie)
static func align_y_3D(xform:Transform3D, new_y:Vector3) -> Transform3D: ## Rotates the given Transform3D so that it's up direction aligns with the specified up direction. Used for gravity manipulation.
	if new_y != Vector3.ZERO: #Quick checks, as we run into a div-by-zero error if new_y is 0. Explicitly defined for readability.
		new_y = new_y.normalized() #Normalize the vector for usage in unscaled basis. Basis is effectively a definition of what the X Y and Z axis' are in 3D space. 
		xform.basis.y = new_y #Sets the LOCAL y to the new y
		xform.basis.x = -xform.basis.z.cross(new_y) #Takes the cross product of the current Z and new Y (gives a vector perpendicular to both.)
		xform.basis = xform.basis.orthonormalized() #Orthonormalizes the matrix, ensuring all 3 vectors are perpendicular to each other.
	return xform #Returns the new transform.

#Author: StrawberrySmoothieDev (Smoothie)
static func align_y_2D(xform:Transform2D, new_y:Vector2) -> Transform3D: ## Rotates the given Transform2D so that it's up direction aligns with the specified up direction. Used for gravity manipulation. 
	if new_y != Vector2.ZERO: #Quick checks, as we run into a div-by-zero error if new_y is 0. 
		new_y = -new_y.normalized() #Normalize the vector for the "same" reason as before, the only exception being that Transform2D's don't have a basis, they just simply have an xdef and a ydef vector defs.
		xform.y = new_y #Sets the LOCAL y to the new y
		xform.x = xform.y.orthogonal() #Instead of just orthanormalizing the whole transform, we simply take the vector that is orthogonal to ydef (effectively a perpendicular vector) and set xdef to that.
	return xform #Returns the new transform.
