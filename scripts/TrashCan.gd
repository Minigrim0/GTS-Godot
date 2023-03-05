extends Area2D

var velocity = Vector2.ZERO

func _ready():
	$ExplosionSprite.hide()
	velocity = Vector2.ZERO
	$"/root/PlayerState".add_spawned_item("trash", 1)

func explode():
	$AnimationPlayer.current_animation = "Explode"
	$ExplosionSprite.show()
	$TrashCanSprite.hide()

func die():
	queue_free()

func _on_TrashCan_body_entered(body):
	if body.name == "Truck":
		body.trashCollected()
		$"/root/PlayerState".add_collected_item("trash", 1)
		explode()
