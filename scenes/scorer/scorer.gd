extends Node

class_name Scorer

@onready var reveal_timer: Timer = $RevealTimer

var _selections: Array[MemoryTile] = []
var _target_pairs: int = 0
var _moves_made: int = 0
var _pairs_made: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_tile_selected.connect(on_tile_selected)
	SignalManager.on_game_exit_pressed.connect(on_game_exit_pressed)

func clear_new_game(target_pairs: int) -> void:
	_selections.clear()
	_target_pairs = target_pairs
	_moves_made = 0
	_pairs_made = 0

func kill_tiles() -> void:
	for tile in _selections:
		tile.kill_on_success()
	_pairs_made += 1 
 
func selections_are_pair() -> bool:
	return _selections[0].matches_other_tile(_selections[1])

func check_pair_made() -> void:
	if _selections.size() != 2:
		return
	reveal_timer.start()
	SignalManager.on_selection_disabled.emit()
	_moves_made += 1	
	if selections_are_pair() == true:
		kill_tiles()

func check_game_over() -> void:
	if _target_pairs == _pairs_made:
		SignalManager.on_game_over.emit(_moves_made)

func on_tile_selected(tile: MemoryTile) -> void:
	tile.reveal(true)
	_selections.append(tile)
	check_pair_made()

func on_game_exit_pressed() -> void:
	reveal_timer.stop()

func _on_reveal_timer_timeout() -> void:
	if selections_are_pair() == false:
		for tile in _selections:
			tile.reveal(false)
	_selections.clear()
	check_game_over()
	SignalManager.on_selection_enabled.emit()

func get_moves_made_str() -> String:
	return str(_moves_made)

func get_pairs_made_str() -> String:
	return "%d/%d" % [_pairs_made, _target_pairs]
