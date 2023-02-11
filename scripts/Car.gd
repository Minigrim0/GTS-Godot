extends KinematicBody2D

export(int) var speed
export(bool) var heading # True = to the left, False = to the right

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = rand_range(30, 50)
	if heading == true:
		velocity.x = -speed
	else:
		velocity.x = -speed
	heading = rand_range(0.0, 1.0) < 0.8

	if not heading:
		$CarSprite.set_flip_h(true)

	$ExplosionSprite.hide()

func die():
	queue_free()

func _physics_process(delta):
	velocity.x = (-1) * int(heading) * speed * delta
	var collision = move_and_collide(velocity)
	if collision != null:
		$CarSprite.hide()
		speed = 0
		velocity = Vector2.ZERO
		$ExplosionSprite.show()
		$ExplosionAnimationPlayer.current_animation = "Explode"
		$CollisionShape2D.disabled = true
