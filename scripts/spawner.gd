extends Node2D

@export_file("*.tscn") var object_to_spawn
@export var spawn_pixel_cooldown: int = 2000 # pixels
@export_enum("Random", "Sine", "Not defined") var spawn_type: int
@export var upper_bound: int = 750
@export var lower_bound: int = 375

var object  # The object to spawn
var meters_at_last_spawn


func _ready():
	object = load(object_to_spawn)
	meters_at_last_spawn = global_position.x


func _process(_delta):
	# Updates the position of the spawner, to determine whether to spawn a trashcan or not
	if global_position.x - meters_at_last_spawn >= spawn_pixel_cooldown:
		spawn()
		meters_at_last_spawn = global_position.x


func spawn():
	# Changes the position in y of the spawner randomly within the correct area)
	# And spawns a trashcan as child of the root component
	global_position.y = randf_range(lower_bound, upper_bound)
	var objInstance = object.instantiate()
	objInstance.position  = global_position
	get_tree().get_root().add_child(objInstance)
