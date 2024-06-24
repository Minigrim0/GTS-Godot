extends Area2D

func _on_GarbageCollector_body_entered(body):
	body.queue_free.call_deferred()


func _on_GarbageCollector_area_entered(area):
	area.queue_free.call_deferred()
