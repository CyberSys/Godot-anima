class_name AnimaDeclarationGroup
extends AnimaDeclarationNode

func _init_me(group: Node, items_delay: float, animation_type: int, point: int) -> AnimaDeclarationGroup:
	._set_data({
		group = group,
		items_delay = items_delay,
		animation_type = animation_type,
		point = Vector2(point, 0),
		distance_formula = ANIMA.DISTANCE.EUCLIDIAN
	})

	return self

func anima_distance_formula(distance_formula: int) -> AnimaDeclarationGroup:
	self._data.distance_foruma = distance_formula

	return self
