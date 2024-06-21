extends Node2D

@export var object_to_spawn: PackedScene
@export var spawn_pixel_cooldown: int = 2000 # pixels
@export var spawn_type: int  # (int, "Random", "Sine", "Not defined")
@export var upper_bound: int = 750
@export var lower_bound: int = 375

var meters_at_last_spawn


func _ready():
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
	var objInstance = object_to_spawn.instantiate()
	objInstance.position  = global_position
	get_tree().get_root().add_child(objInstance)
