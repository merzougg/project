extends CharacterBody2D

var pv = 60
const SPEED = 350.0
const JUMP_VELOCITY = -300.0
var taking_damage = false
@onready var animated_sprite_2d = $AnimatedSprite2D

func respawn():
	self.global_position = Vector2(0,0)

func take_damage(amount: int) -> void:
	pv -= amount
	print("Player HP:", pv)
	if pv <= 0:
		die()
	else:
		taking_damage = true
		animated_sprite_2d.play("dam")

func die():
	pv = 60
	respawn()

func _physics_process(delta: float) -> void:
	# Handle damage animation
	if taking_damage:
		if not animated_sprite_2d.is_playing():
			taking_damage = false
			animated_sprite_2d.play("default")  # Return to idle

	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not taking_damage:
		velocity.y = JUMP_VELOCITY

	# Movement
	if not taking_damage:
		var direction := Input.get_axis("ui_left", "ui_right")
		velocity.x = direction * SPEED
		if direction:
			animated_sprite_2d.play("move left")
			animated_sprite_2d.flip_h = direction < 0
		else:
			animated_sprite_2d.play("default")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
