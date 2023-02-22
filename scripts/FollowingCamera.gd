extends Node2D

export(NodePath) var followed_item

func _process(_delta):
	if followed_item != null:
		position.x = get_node(followed_item).position.x


func _on_LevelEnd_area_entered(area):
	if area.name == "EndCollisionCheck":
		followed_item = null
