class_name SelectedLevelData

var _selected_level_images: Array[ItemImage]
var _target_pairs: int
var _num_cols: int

func _init(selected_level_images: Array[ItemImage], target_pairs: int, num_cols: int) -> void:
	_selected_level_images = selected_level_images
	_target_pairs = target_pairs
	_num_cols = num_cols

func get_selected_level_images() -> Array[ItemImage]:
	return _selected_level_images

func get_target_pairs() -> int:
	return _target_pairs

func get_num_cols() -> int:
	return _num_cols
