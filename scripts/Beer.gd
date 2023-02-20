extends Area2D

export(float) var alcohol_level = 4.8
export(float) var health_bonus = 5


func _on_Node2D_body_entered(body):
	if body.name == "Truck":
		body.heal(health_bonus)
		body.add_alcohol(alcohol_level)
		queue_free()
