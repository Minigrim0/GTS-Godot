extends Area2D

var velocity = Vector2.ZERO

func _ready():
	$ExplosionSprite.hide()
	velocity = Vector2.ZERO

func explode():
	$AnimationPlayer.current_animation = "Explode"
	$ExplosionSprite.show()
	$TrashCanSprite.hide()
	$CollisionShape2D.disabled = true

func die():
	queue_free()

func _on_TrashCan_body_entered(body):
	if body.name == "Truck":
		explode()
