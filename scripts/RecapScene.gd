extends Node2D

export(int) var trashCollected = 0
export(float) var totalTime = 0  # In seconds
export(float) var efficiency = 0  # In percent
export(int) var topSpeed = 0  # In km/h

var score_text = "A"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Create a score from 1 to 5 based on the efficiency, top speed and total time
	var score = 0
	score += int(efficiency * 10)
	score += int((topSpeed / 150) * 10)
	score += int((10 - (totalTime / 60)) * 10)
	score = clamp(score, 0, 50)

	# Create a score text based on the score
	if score < 25:
		score_text = "C"
	elif score < 50:
		score_text = "B"
	else:
		score_text = "A"

func playScore():
	pass
