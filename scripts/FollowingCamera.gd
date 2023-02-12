extends Node2D

export(NodePath) var followed_item

func _ready():
	if followed_item == null:
		followed_item = "Truck"

func _process(_delta):
	position.x = get_node(followed_item).position.x
