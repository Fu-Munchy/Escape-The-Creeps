extends CharacterBody2D

@export var speed = 400
var screen_size
var direction
signal hit

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Gets the size of the viewport on loading
	screen_size = get_viewport_rect().size
	hide()
	

# Player movement
#Get player input
func get_input():
	direction = Input.get_vector("move_left","move_right","move_up","move_down")
	# Move the character in that direction by a certain speed
	velocity = direction*speed 
	#Apply an animation when moving in that direction and rotate the character
	if direction:
		$AnimatedSprite2D.play("Up")
		rotation=direction.angle()+(PI/2)
	else:
	# If standing still, rotate character to 0rad and play Idle animation.
		$AnimatedSprite2D.play("Idle")
		rotation=0


func collision_detection():
	# Detects what entity was collided with - using for loop to keep calculating
	# how many times collisions have happened, and then getting the name of each
	# collision.
	var collided_with
	for i in get_slide_collision_count():
		collided_with = get_slide_collision(i).get_collider().name
	# If the collision boundary name is "World Border" then do nothing, else
	# Hide the player character, and disable its collider.
		if collided_with == "World border":
			pass
		else:
			hide()
			$CollisionShape2D.set_deferred("disabled", true)
			emit_signal("hit")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	collision_detection()
	get_input()
	move_and_slide()
