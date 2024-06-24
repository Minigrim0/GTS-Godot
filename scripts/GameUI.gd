extends Node2D

@export var followedItemPath: NodePath
@export var endOfLevelPath: NodePath
@export var truckPath: NodePath

var followedItem
var endOfLevel
var truck


func _ready():
	$"/root/PlayerState".level_start()
	if endOfLevelPath != null:
		endOfLevel = get_node(endOfLevelPath)
	else:
		print("Warning, end of level not loaded")
	if followedItemPath != null:
		followedItem = get_node(followedItemPath)
	else:
		print("Warning, followed item not loaded")
	if truckPath != null:
		truck = get_node(truckPath)
	else:
		print("Warning, truck not loaded")


func _process(_delta):
	if followedItem != null:
		position.x = followedItem.position.x - 300
	updateGauges()
	updateTextElements()


func _on_LevelEnd_area_entered(area):
	if area.name == "EndCollisionCheck":
		print("End")
		followedItem = null


func _on_TruckEndCollisionCheck_body_entered(body):
	if body.name == "Truck":
		$"/root/PlayerState".level_end()
		assert(get_tree().change_scene_to_file("res://scenes/RecapScene.tscn") == 0, "Error while loading the recap")


func updateGauges():
	var nitro_level = truck.get_nitro_level()
	$MarginContainer/VBoxContainer/HBoxContainer/NitroGauge/TextureProgressBar.value = nitro_level
	$MarginContainer/VBoxContainer/HBoxContainer/NitroGauge/NitroPercent.text = "%d%%" % nitro_level

	var speed = truck.get_speed()
	$MarginContainer/VBoxContainer/HBoxContainer/SpeedGauge/TextureProgressBar.value = speed
	$MarginContainer/VBoxContainer/HBoxContainer/SpeedGauge/SpeedText.text = "%d km/h" % speed

	var alcohol_level = truck.get_alcohol_level()
	$MarginContainer/VBoxContainer/HBoxContainer/AlcoholGauge/TextureProgressBar.value = alcohol_level
	$MarginContainer/VBoxContainer/HBoxContainer/AlcoholGauge/AlcoholText.text = "%f%%" % alcohol_level


func updateTextElements():
	if endOfLevel != null:
		$MarginContainer/VBoxContainer/HBoxContainer/Informations/ValuesVBoxContainer/DistanceLeft.text = "%d meters" % ($"/root/PlayerState".get_distance_covered())
	$MarginContainer/VBoxContainer/HBoxContainer/Informations/ValuesVBoxContainer/TopSpeed.text = str("%d km/h" % $"/root/PlayerState".get_top_speed())
	$MarginContainer/VBoxContainer/HBoxContainer/Informations/ValuesVBoxContainer/Income.text = str("%d €" % $"/root/PlayerState".get_score())
	$MarginContainer/VBoxContainer/HBoxContainer/Informations/ValuesVBoxContainer/Efficiency.text = str("%d%%" % $"/root/PlayerState".get_efficiency("trash"))
