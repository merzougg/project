extends CharacterBody2D

var pv = 60
var SPEED = 350.0
const JUMP_VELOCITY = -300.0
var taking_damage = false
var death = false

@onready var animated_sprite_2d = $AnimatedSprite2D

func respawn():
	pv = 60
	death = false
	taking_damage = false
	self.global_position = Vector2(0, 0)
	animated_sprite_2d.play("default")

func take_damage(amount: int) -> void:
	if death:
		return
	
	pv -= amount
	
	if pv <= 0:
		die()
	else:
		taking_damage = true
		animated_sprite_2d.play("dam")

func die():
	death = true
	taking_damage = false
	animated_sprite_2d.play("death")

func _physics_process(delta: float) -> void:
	if death:
		if Input.is_action_just_pressed("ui_up"):
			respawn()
		return 

	# Handle damage animation reset
	if taking_damage and not animated_sprite_2d.is_playing():
		taking_damage = false
		animated_sprite_2d.play("default")

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not taking_damage:
		velocity.y = JUMP_VELOCITY

	# Movement
	if not taking_damage:
		var direction := Input.get_axis("ui_left", "ui_right")
		velocity.x = direction * SPEED
		

		if direction != 0:
			animated_sprite_2d.play("move")
			animated_sprite_2d.flip_h = direction < 0
		else:
			animated_sprite_2d.play("default")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
