extends Node2D

const base_speed := 100
const speed_up_multiplier := 10.0
const title_color := Color.black

var speed_up := false

onready var line := $CreditsContainer/Line
onready var sectionLine := $CreditsContainer/SectionTitle
onready var titleLine := $CreditsContainer/TitleLine
onready var richLine := $CreditsContainer/RichLine

var section_separation = 0
var section_distance = 1
var lines := []

export(String, FILE, "*.json") var credits_file
var credits = {}


func load_credits():
	var file = File.new()
	file.open(credits_file, File.READ)
	credits = JSON.parse(file.get_as_text()).result
	file.close()


func _ready():
	load_credits()


func _process(delta):
	var local_scroll_speed = base_speed * delta

	section_distance += local_scroll_speed * speed_up_multiplier if speed_up else local_scroll_speed  # Raise the timer
	if section_distance >= section_separation:  # If the timer is above the threshold
		section_distance -= section_separation

		if credits.size() > 0:  # If there is still something in the credits
			var section = credits.pop_front()  # Take the first element
			add_section(section)  # Add a line

	if speed_up:
		local_scroll_speed *= speed_up_multiplier

	if lines.size() > 0:
		for l in lines:
			l.rect_position.y -= local_scroll_speed
			if l.rect_position.y < -l.get_size().y:
				lines.erase(l)
				l.queue_free()
		if lines.size() == 0:
			finish()


func finish():
	assert(get_tree().change_scene("res://scenes/MainMenu.tscn") == 0, "Error while change scene to Main Menu")


func add_string(index, value):
	var value_line = line.duplicate()
	value_line.text = value
	value_line.rect_position.y += (index + 3) * (value_line.rect_size.y + 5)
	$CreditsContainer.add_child(value_line)
	lines.append(value_line)

func onMetaClick(meta):
	assert(OS.shell_open(meta) == 0, "An error occured while opening a link")

func add_dictionnary(index, dict):
	if dict["type"] == "fstring":
		var rich_line = richLine.duplicate()
		var formatted_line = dict["value"]
		for key in dict["urls"]:
			var formatted = "[url=%s]%s[/url]" % [dict["urls"][key], key]
			formatted_line = formatted_line.replace(key, formatted)
		formatted_line = "[center]%s[/center]" % formatted_line
		rich_line.bbcode_text = formatted_line
		rich_line.rect_position.y += (index + 2) * (rich_line.rect_size.y + 5)
		rich_line.connect("meta_clicked", self, "onMetaClick")

		$CreditsContainer.add_child(rich_line)
		lines.append(rich_line)


func add_title(section):
	var title_line
	if section.has("type") and section["type"] == "big title":
		title_line = titleLine.duplicate()
	else:
		title_line = sectionLine.duplicate()
		title_line.add_color_override("font_color", title_color)
	title_line.text = section["name"]
	$CreditsContainer.add_child(title_line)
	lines.append(title_line)


func add_section(section):
	add_title(section)
	var last_index = 1

	for index in section["values"].size():
		var val_type = typeof(section["values"][index])
		if val_type == TYPE_STRING:
			add_string(index, section["values"][index])
		elif val_type == TYPE_DICTIONARY:
			add_dictionnary(index, section["values"][index])
		last_index = index

	section_separation = (last_index + 5) * 60

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false
