extends Node2D

onready var trashCan = preload("res://assets/prefabs/TrashCan.tscn")

export(int) var spawn_cooldown = 200 # pixels

var meters_at_last_spawn

func _ready():
	meters_at_last_spawn = global_position.x

func _process(_delta):
	# Updates the position of the spawner, to determine whether to spawn a trashcan or not
	if global_position.x - meters_at_last_spawn >= spawn_cooldown:
		spawn()
		meters_at_last_spawn = global_position.x

func spawn():
	# Changes the position in y of the spawner randomly within the correct area)
	# And spawns a trashcan as child of the root component
	global_position.y = 550 + rand_range(-200, 200)
	var trashInstance = trashCan.instance()
	trashInstance.position  = global_position
	get_tree().get_root().add_child(trashInstance)
