var _utils = load('res://addons/gut/utils.gd').get_instance()
var _strutils = _utils.Strutils.new()
var _max_length = 100
var _should_compare_int_to_float = true

const MISSING = '|__missing__gut__compare__value__|'
const DICTIONARY_DISCLAIMER = 'Dictionaries are compared-by-ref.  See assert_eq in wiki.'

func _cannot_comapre_text(v1, v2):
	return str('Cannot compare ', _strutils.types[typeof(v1)], ' with ',
		_strutils.types[typeof(v2)], '.')

func _make_missing_string(text):
	return '<missing ' + text + '>'

func _create_missing_result(v1, v2, text):
	var to_return = null
	var v1_str = format_value(v1)
	var v2_str = format_value(v2)

	if(typeof(v1) == TYPE_STRING and v1 == MISSING):
		v1_str = _make_missing_string(text)
		to_return = _utils.CompareResult.new()
	elif(typeof(v2) == TYPE_STRING and v2 == MISSING):
		v2_str = _make_missing_string(text)
		to_return = _utils.CompareResult.new()

	if(to_return != null):
		to_return.summary = str(v1_str, ' != ', v2_str)
		to_return.are_equal = false

	return to_return


func simple(v1, v2, missing_string=''):
	var missing_result = _create_missing_result(v1, v2, missing_string)
	if(missing_result != null):
		return missing_result

	var result = _utils.CompareResult.new()
	var cmp_str = null
	var extra = ''

	if(_should_compare_int_to_float and [2, 3].has(typeof(v1)) and [2, 3].has(typeof(v2))):
		result.are_equal = v1 == v2

	elif(_utils.are_datatypes_same(v1, v2)):
		if typeof(v1) == TYPE_REAL and v2 != null:
			result.are_equal = round(v1 * 100) == round(v2 * 100)
		else:
			result.are_equal = v1 == v2

		if(typeof(v1) == TYPE_DICTIONARY):
			if(result.are_equal):
				extra = '.  Same dictionary ref.  '
			else:
				extra = '.  Different dictionary refs.  '
			extra += DICTIONARY_DISCLAIMER

		if(typeof(v1) == TYPE_ARRAY):
			var array_result = _utils.DiffTool.new(v1, v2, _utils.DIFF.SHALLOW)
			result.summary = array_result.get_short_summary()
			if(!array_result.are_equal()):
				extra = ".\n" + array_result.get_short_summary()

	else:
		cmp_str = '!='
		result.are_equal = false
		extra = str('.  ', _cannot_comapre_text(v1, v2))

	cmp_str = get_compare_symbol(result.are_equal)
	result.summary = str(format_value(v1), ' ', cmp_str, ' ', format_value(v2), extra)

	return result


func shallow(v1, v2):
	var result =  null

	if(_utils.are_datatypes_same(v1, v2)):
		if(typeof(v1) in [TYPE_ARRAY, TYPE_DICTIONARY]):
			result = _utils.DiffTool.new(v1, v2, _utils.DIFF.SHALLOW)
		else:
			result = simple(v1, v2)
	else:
		result = simple(v1, v2)

	return result


func deep(v1, v2):
	var result =  null

	if(_utils.are_datatypes_same(v1, v2)):
		if(typeof(v1) in [TYPE_ARRAY, TYPE_DICTIONARY]):
			result = _utils.DiffTool.new(v1, v2, _utils.DIFF.DEEP)
		else:
			result = simple(v1, v2)
	else:
		result = simple(v1, v2)

	return result


func format_value(val, max_val_length=_max_length):
	return _strutils.truncate_string(_strutils.type2str(val), max_val_length)


func compare(v1, v2, diff_type=_utils.DIFF.SIMPLE):
	var result = null
	if(diff_type == _utils.DIFF.SIMPLE):
		result = simple(v1, v2)
	elif(diff_type == _utils.DIFF.SHALLOW):
		result = shallow(v1, v2)
	elif(diff_type ==  _utils.DIFF.DEEP):
		result = deep(v1, v2)

	return result


func get_should_compare_int_to_float():
	return _should_compare_int_to_float


func set_should_compare_int_to_float(should_compare_int_float):
	_should_compare_int_to_float = should_compare_int_float


func get_compare_symbol(is_equal):
	if(is_equal):
		return '=='
	else:
		return '!='
