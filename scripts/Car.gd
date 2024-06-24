extends Area2D

@export var speed: float
@export var heading_left: bool # True = to the left, False = to the right
@export var damage: int = 10

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = randf_range(30, 50)
	if heading_left == true:
		velocity.x = -speed
	else:
		velocity.x = speed
	heading_left = randf_range(0.0, 1.0) < 0.8

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

func _physics_process(delta):
	velocity.x = pow(-1, int(heading_left)) * speed * delta
	position += velocity

func _on_Car_body_entered(body):
	if body.name == "Truck":
		body.hurt(damage)
		explode()
