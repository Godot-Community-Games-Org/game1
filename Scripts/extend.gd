class_name extend

# Extend class:
# a class containing static functions for global use.

#Gets all of the parents children (grand children, great grand children, ect)
static func get_all_Children(root_node) -> Array[Node]:
	var nodes: Array[Node] = []
	for node in root_node.get_children():
		nodes.append(node)
		if node.get_child_count() > 0:
			nodes += get_all_Children(node)
	return nodes
