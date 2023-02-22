extends Area2D

func _on_GarbageCollector_body_entered(body):
	body.queue_free()


func _on_GarbageCollector_area_entered(area):
	area.queue_free()
