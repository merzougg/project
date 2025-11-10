extends Node2D

const MyScene = preload("res://scnes/character_body_2d.tscn")
var direction = 1 
var speed = 60 
@onready var animated_sprite_2d:  = $AnimatedSprite2D

@onready var player = $"../player" 
@onready var riht = $riht
@onready var left = $left

func _ready():
	riht.add_exception(player)
	left.add_exception(player)
	animated_sprite_2d.stop()
func _process(delta: float) -> void:
	if riht.is_colliding():
		direction = -1
	if left.is_colliding():
		direction = 1
	position.x += speed * delta * direction
