extends Label

@export var michel_path: NodePath

var michel

func _ready():
	michel = get_node(michel_path)
	mouse_filter = 0

func _on_mouse_entered():
	if michel.is_done():
		michel.start()
