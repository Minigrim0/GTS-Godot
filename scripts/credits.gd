extends Node2D

const section_time := 2.0
const line_time := 0.3
const base_speed := 100
const speed_up_multiplier := 10.0
const title_color := Color.blueviolet

var scroll_speed := base_speed
var speed_up := false

onready var line := $CreditsContainer/Line
var started := false
var finished := false

var section_next := true
var section_timer := 0.0
var lines := []

export(String, FILE, "*.json") var credits_file
var credits

func load_credits():
	var file = File.new()
	file.open(credits_file, File.READ)
	credits = JSON.parse(file.get_as_text()).result
	file.close()


func _ready():
	load_credits()


func _process(delta):
	var scroll_speed = base_speed * delta

	if section_next:  # If a new section is starting (Or must start)
		section_timer += delta * speed_up_multiplier if speed_up else delta  # Raise the timer
		if section_timer >= section_time:  # If the timer is above the threshold
			section_timer -= section_time

			if credits.size() > 0:  # If there is still something in the credits
				var section = credits.pop_front()  # Take the first element
				add_section(section)  # Add a line

	if speed_up:
		scroll_speed *= speed_up_multiplier

	if lines.size() > 0:
		for l in lines:
			l.rect_position.y -= scroll_speed
			if l.rect_position.y < -l.get_line_height():
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		get_tree().change_scene("res://scenes/MainMenu.tscn")


func add_section(section):
	var section_title = section["name"]
	var title_line = line.duplicate()
	title_line.text = section_title
	title_line.add_color_override("font_color", title_color)
	$CreditsContainer.add_child(title_line)
	lines.append(title_line)

	for index in section["values"].size():
		var value_line = line.duplicate()
		value_line.text = section["values"][index]
		value_line.rect_position.y += (index + 2) * (value_line.rect_size.y + 5)
		$CreditsContainer.add_child(value_line)
		lines.append(value_line)

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false
