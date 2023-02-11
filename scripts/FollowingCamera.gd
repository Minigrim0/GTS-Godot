extends Camera2D


# Declare member variables here. Examples:
export(NodePath) var followed_item

# Called when the node enters the scene tree for the first time.
# func _ready():
# 	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position.x = get_node(followed_item).position.x
