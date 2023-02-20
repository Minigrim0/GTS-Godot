extends KinematicBody2D

export(int) var steering_speed = 100
export(int) var nitro_replenish_speed = 10
export(int) var nitro_spending_speed = 30  # Per second
export(int) var speed = 300 # px/second = 3m/s = 10.8km/h
export(float) var health = 100.0

export(String, "Male", "Female") var driver_gender = "Male"

var alcohol_level = 0.0  # mg/L

var velocity = Vector2(0, 0)
var nitro_level = 0
var nitro_cooldown = 0
var nitro_enabled = false

func _ready():
	$TruckBounce.current_animation = "Balance"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if nitro_enabled:
		nitro_level -= nitro_spending_speed * delta
		if nitro_level <= 0:
			disable_nitro()
	elif nitro_cooldown > 0:
		# Diminish nitro cooldown
		nitro_cooldown -= delta
	else:
		# Make the nitro level go higher
		nitro_level += delta * nitro_replenish_speed

	if alcohol_level > 0:
		# An hour is 2 minutes irl, delta is in seconds
		alcohol_level -= 0.015 * delta / 120

func upd_health(delta):
	# Delta can be negative to account for damage
	health += delta
	$HealthBar.value = health

func hurt(damage):
	upd_health(-damage)

func heal(amount):
	upd_health(amount)

func add_alcohol(percent):
	# BAC = [Alcohol consumed in grams / (Body weight in grams x r)] x 100.
	# “r” is the gender constant: r = 0.55 for females and 0.68 for males.
	# 1 Standard drink = 1 beer @ 5% => Take the percent of the beer modulo 5
	# Multiply the standard drinks amount by 14 => grams of alcohol
	# Multiply the bodyweight by the gender constant
	# Divide the grams of alcohol by the result above
	# This is the percent of alcohol in the blood
	# Substract 0.015 per hour
	# An hour in game is 2 minutes irl
	var standard_drinks = percent % 5
	var grams_of_alcohol = standard_drinks * 14
	var bodyweight = 70
	var r = 0.68 if driver_gender == "Male" else 0.55
	var bac = (grams_of_alcohol / (bodyweight * r)) * 100

func trashCollected():
	speed += 5

func enable_nitro():
	if nitro_enabled == false and nitro_level > 20:
		nitro_enabled = true
		$Nitro/NitroSprite.show()
		$Nitro/NitroAnimation.current_animation = "Nitro"
		$Nitro/AudioStreamPlayer.play()
		speed *= 2

func disable_nitro():
	nitro_enabled = false
	nitro_cooldown = 5
	$Nitro/NitroSprite.hide()
	$Nitro/NitroAnimation.current_animation = ""
	speed /= 2

func _input(event):
	if event.is_action_pressed("nitro_start"):
		enable_nitro()

func process_movement():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1.0
	if Input.is_action_pressed("move_down"):
		velocity.y += 1.0
	velocity = velocity.normalized() * steering_speed
	velocity.x = speed

func _physics_process(_delta):
	process_movement()
	velocity = move_and_slide(velocity)
