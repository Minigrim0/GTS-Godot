extends Node2D

const base_speed := 100
const speed_up_multiplier := 10

var speed_up := false

export(String, FILE, "*.txt") var credits_file


func load_credits():
	var file = File.new()
	file.open(credits_file, File.READ)
	$Credits.bbcode_text = file.get_as_text()
	assert($Credits.connect("meta_clicked", self, "onMetaClick") == 0, "Error connecting clicks")
	file.close()


func _ready():
	load_credits()


func _process(delta):
	var local_scroll_speed = base_speed * delta

	if speed_up:
		local_scroll_speed *= speed_up_multiplier
	$Credits.rect_position.y -= local_scroll_speed
	if $Credits.rect_position.y < -$Credits.get_size().y:
		finish()


func finish():
	assert(get_tree().change_scene("res://scenes/MainMenu.tscn") == 0, "Error while change scene to Main Menu")


func onMetaClick(meta):
	assert(OS.shell_open(meta) == 0, "An error occured while opening a link")


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false
