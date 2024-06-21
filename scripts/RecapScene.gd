extends Node2D

var trashCollected = 0
var totalTime = 0.0  # In seconds
var efficiency = 0.0  # In percent
var topSpeed = 0  # In km/h
var income = 0

var audio_to_play

const score_a := Color.GREEN
const score_b := Color.ORANGE
const score_c := Color.RED


# Called when the node enters the scene tree for the first time.
func _ready():
	# Create a score from 1 to 5 based on the efficiency, top speed and total time

	get_node("/root/MainMusicPlayer").volume_db = -20

	trashCollected = $"/root/PlayerState".get_collected("trash")
	totalTime = $"/root/PlayerState".get_timer()
	efficiency = $"/root/PlayerState".get_efficiency("trash")
	topSpeed = $"/root/PlayerState".get_top_speed()
	income = $"/root/PlayerState".get_score()

	var score_text
	var score = 0
	score = (efficiency / 100) * clamp(topSpeed / 150, 0, 1) * 50
	# Create a score text based on the score
	if score < 25:
		score_text = "C"
		$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/HBoxContainer6/NValue.add_theme_color_override("font_color", score_c)
		audio_to_play = $ScoreSounds/C
	elif score < 50:
		score_text = "B"
		$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/HBoxContainer6/NValue.add_theme_color_override("font_color", score_b)
		audio_to_play = $ScoreSounds/B
	else:
		score_text = "A"
		$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/HBoxContainer6/NValue.add_theme_color_override("font_color", score_a)
		audio_to_play = $ScoreSounds/A

	$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/CollectedTrash/CTValue.text = str(trashCollected)
	$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/TotalTime/TTValue.text = str(totalTime)
	$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/Efficiency/EValue.text = str(efficiency)
	$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/TopSpeed/TSValue.text = str(topSpeed)
	$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/Income/IValue.text = str(income)
	$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/HBoxContainer6/NValue.text = score_text

	$ScoreAnimation.current_animation = "Summary"


func playScore():
	audio_to_play.playing = true


func endScene():
	get_node("/root/MainMusicPlayer").volume_db = 0
	assert(get_tree().change_scene_to_file("res://scenes/MainMenu.tscn") == 0, "Error while loading main menu")
