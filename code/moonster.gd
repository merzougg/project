extends Node2D
var direction = 1 
var speed = 60 

@onready var player: = $"../player"

@onready var animated_sprite_2d: = $AnimatedSprite2D
@onready var riht:  = $riht
@onready var left:  = $left
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if riht.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h
	if left.is_colliding():
		direction = 1
	animated_sprite_2d.flip_h = direction  <  0
	position.x += speed  *delta*direction
