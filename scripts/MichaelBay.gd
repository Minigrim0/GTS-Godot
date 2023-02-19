extends Node2D


func _ready():
	pass # Replace with function body.


func start():
	$ExplosionAnimationPlayer.current_animation = "showup"

func is_done():
	return $ExplosionAnimationPlayer.current_animation == ""

func stop():
	$ExplosionAnimationPlayer.current_animation = ""
