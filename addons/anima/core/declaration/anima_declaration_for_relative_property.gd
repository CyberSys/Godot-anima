class_name AnimaDeclarationForRelativeProperty
extends AnimaDeclarationBase

# We can't use _init otherwise Godot complains with this nonsense
# Too few arguments for "_init()". Expected at least 1
func _init_me(data: Dictionary) -> AnimaDeclarationForRelativeProperty:
	._init_me(data)

	return self

func anima_easing(easing) -> AnimaDeclarationForRelativeProperty:
	self._data.easing = easing

	return self

func anima_pivot(pivot: int) -> AnimaDeclarationForRelativeProperty:
	self._data.pivot = pivot

	return self

func anima_from(value) -> AnimaDeclarationForRelativeProperty:
	.anima_from(value)

	return self

func anima_to(value) -> AnimaDeclarationForRelativeProperty:
	.anima_to(value)

	return self

func anima_delay(value: float) -> AnimaDeclarationForRelativeProperty:
	.anima_delay(value)

	return self

func anima_visibility_strategy(value: int) -> AnimaDeclarationForRelativeProperty:
	.anima_visibility_strategy(value)

	return self

func anima_initial_value(value) -> AnimaDeclarationForRelativeProperty:
	.anima_initial_value(value)

	return self

func anima_on_started(target: Object, method: String, on_started_value = null, on_backwards_completed_value = null) -> AnimaDeclarationForRelativeProperty:
	.anima_on_started(target, method, on_started_value, on_backwards_completed_value)

	return self

func anima_on_completed(target: Object, method: String, on_completed_value = null, on_backwards_started_value = null) -> AnimaDeclarationForRelativeProperty:
	.anima_on_completed(target, method, on_completed_value, on_backwards_started_value)

	return self
