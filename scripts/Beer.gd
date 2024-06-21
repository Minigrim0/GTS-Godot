extends Area2D

@export var alcohol_level: float = 4.8
@export var health_bonus: float = 5.0


func _on_Node2D_body_entered(body):
	if body.name == "Truck":
		body.heal(health_bonus)
		body.add_alcohol(alcohol_level)
		queue_free()
