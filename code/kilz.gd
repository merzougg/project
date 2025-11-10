extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":  
		print("-10")
		body.take_damage(10)
		
