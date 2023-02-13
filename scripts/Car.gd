extends KinematicBody2D

export(int) var speed
export(bool) var heading_left # True = to the left, False = to the right
export(int) var damage = 10

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = rand_range(30, 50)
	if heading_left == true:
		velocity.x = -speed
	else:
		velocity.x = speed
	heading_left = rand_range(0.0, 1.0) < 0.8

	if not heading_left:
		$CarSprite.set_flip_h(true)
	$ExplosionSprite.hide()

func die():
	queue_free()

func explode():
	speed = 0
	velocity = Vector2.ZERO

	$CarSprite.hide()
	$ExplosionSprite.show()
	$ExplosionAnimationPlayer.current_animation = "Explode"
	$CollisionShape.disabled = true

func _physics_process(delta):
	velocity.x = pow(-1, int(heading_left)) * speed * delta
	var collision = move_and_collide(velocity)
	if collision != null and collision.collider.name == "Truck":
		collision.collider.hurt(10)
		explode()
