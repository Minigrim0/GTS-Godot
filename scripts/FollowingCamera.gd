extends Node2D

export(NodePath) var followedItemPath
export(NodePath) var distanceLeftLabelPath
export(NodePath) var endOfLevelPath

var followedItem
var distanceLeftLabel
var endOfLevel


func _ready():
	if distanceLeftLabelPath != null:
		distanceLeftLabel = get_node(distanceLeftLabelPath)
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


func updDistanceLeft():
	if endOfLevel != null:
		distanceLeftLabel.text = "%d meters" % ((endOfLevel.position.x - position.x) / 100)
