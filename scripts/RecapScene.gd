extends Node2D

export(int) var trashCollected = 0
export(float) var totalTime = 0.0  # In seconds
export(float) var efficiency = 0.0  # In percent
export(int) var topSpeed = 0  # In km/h
export(int) var income = 0

var audio_to_play

const score_a := Color.green
const score_b := Color.orange
const score_c := Color.red


# Called when the node enters the scene tree for the first time.
func _ready():
	# Create a score from 1 to 5 based on the efficiency, top speed and total time

	get_node("/root/MainMusicPlayer").stream_paused = true

	var score_text
	var score = 0
	score += int(efficiency * 10)
	score += int((topSpeed / 150) * 10)
	score += int((10 - (totalTime / 60)) * 10)
	score = clamp(score, 0, 50)
	# Create a score text based on the score
	if score < 25:
		score_text = "C"
		$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/HBoxContainer6/NValue.add_color_override("font_color", score_c)
		audio_to_play = $ScoreSounds/C
	elif score < 50:
		score_text = "B"
		$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/HBoxContainer6/NValue.add_color_override("font_color", score_b)
		audio_to_play = $ScoreSounds/B
	else:
		score_text = "A"
		$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/HBoxContainer6/NValue.add_color_override("font_color", score_a)
		audio_to_play = $ScoreSounds/A

	$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/CollectedTrash/CTValue.text = str(trashCollected)
	$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/TotalTime/TTValue.text = str(totalTime)
	$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/Efficiency/EValue.text = str(efficiency)
	$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/TopSpeed/TSValue.text = str(topSpeed)
	$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/Income/IValue.text = str(income)
	$Text/VBoxContainer/VBoxContainer2/Blackboard/VBoxContainer/HBoxContainer6/NValue.text = score_text

	$ScoreAnimation.current_animation = "Summary"
	# $ScoreAnimation.play()


func playScore():
	audio_to_play.playing = true


func endScene():
	print("End of the scene, let's go garage")
