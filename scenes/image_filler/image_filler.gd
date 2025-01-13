extends Node

const PATH: String = "res://assets/glitch/"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dir: DirAccess = DirAccess.open(PATH)
	var ifl: ImageFilesList = ImageFilesList.new()
	if dir:
		var files: PackedStringArray = dir.get_files()
		for fn in files:
			ifl.add_filename(PATH + fn)
	ResourceSaver.save(ifl,"res://resources/image_files_list.tres")
 
