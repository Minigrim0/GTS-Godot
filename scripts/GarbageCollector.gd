extends Area2D

func _on_GarbageCollector_body_entered(body):
	body.queue_free()
