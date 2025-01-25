extends Node


func count_nodes_in_group(parent: Node, group_name: String) -> int:
	var count = 0
	for child in parent.get_children():
		if child.is_in_group(group_name):
			count += 1
	return count
