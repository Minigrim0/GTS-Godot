extends Node2D

# Global
var euros
var current_health = 100

# Current level
var spawned_items = {}
var collected_items = {}

var distance_covered: float = 0.0
var score: int = 0
var level_timer = 0
var ongoing = false
var top_speed = 0


func load_save_file(_path):
	pass


func save(_save_name):
	pass


func get_money():
	return euros


func add_money(to_add):
	euros += to_add


func _process(delta):
	if ongoing:
		level_timer += delta


# Current level
func reset_level():
	spawned_items = {}
	collected_items = {}
	score = 0
	level_timer = 0
	top_speed = 0


func level_start():
	ongoing = true


func level_end():
	ongoing = false


func get_timer():
	return level_timer


func upd_score(delta):
	score += delta


func get_score():
	return score


func set_top_speed(speed):
	if speed > top_speed:
		top_speed = speed


func get_top_speed():
	return top_speed


func add_spawned_item(item_name, count):
	if item_name in spawned_items.keys():
		spawned_items[item_name] += count
	else:
		spawned_items[item_name] = count


func add_collected_item(item_name, count):
	if item_name in collected_items.keys():
		collected_items[item_name] += count
	else:
		collected_items[item_name] = count


func get_collected(item_name):
	if item_name in collected_items.keys():
		return collected_items[item_name]
	return 0


func get_efficiency(item_name):
	if item_name in collected_items.keys() and item_name in spawned_items.keys():
		return (float(collected_items[item_name]) / float(spawned_items[item_name])) * 100.0
	return 0


# Returns the disance covered in meters
func get_distance_covered() -> float:
	return distance_covered


func update_distance_covered(delta: float) -> void:
	distance_covered += delta
