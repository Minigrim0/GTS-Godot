extends KinematicBody2D

var velocity = Vector2.ZERO

func _ready():
	$ExplosionSprite.hide()
	velocity = Vector2.ZERO

func body_enter():
	print("bite")

func die():
	queue_free()

func _physics_process(_delta):
	var collision = move_and_collide(Vector2.ZERO)
	if collision != null:
		$AnimationPlayer.current_animation = "Explode"
		$ExplosionSprite.show()
		$TrashCanSprite.hide()
		$CollisionShape2D.disabled = true
