extends Node2D

export(NodePath) var followedItemPath
export(NodePath) var endOfLevelPath

var followedItem
var endOfLevel


func _ready():
	if endOfLevelPath != null:
		endOfLevel = get_node(endOfLevelPath)
	if followedItemPath != null:
		followedItem = get_node(followedItemPath)


func _process(_delta):
	if followedItem != null:
		position.x = followedItem.position.x
	updDistanceLeft()


func _on_LevelEnd_area_entered(area):
	if area.name == "EndCollisionCheck":
		followedItem = null

func _on_TruckEndCollisionCheck_body_entered(body):
	if body.name == "Truck":
		print("End of Level")

func updDistanceLeft():
	if endOfLevel != null:
		$MarginContainer/VBoxContainer/HBoxContainer/Informations/VBoxContainer/DistanceLeft.text = "%d meters" % ((endOfLevel.position.x - position.x) / 100)
