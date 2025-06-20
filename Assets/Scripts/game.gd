extends Node

@export var mob_scene: PackedScene
var score

func _ready() -> void:
	$Background.play()

func game_over():
	$"Timers/Score".stop()
	$"Timers/Mob Timer".stop()
	$HUD.show_game_over()
	$Background.stop()
	$"Death Music".play()

func new_game():
	score = 0
	$Player.start($"Start-position".position)
	$"Timers/Start Timer".start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	if $Background.playing:
		pass
	else:
		$Background.play()

func _on_mob_timer_timeout() -> void:
	#create a new mob based on the mob scene
	var mob = mob_scene.instantiate()
	# draw the mob based on the mob-path, however, the location of is a
	#random location on the mob-path
	var mob_spawn_location = $"Mob Path/Spawn location"
	mob_spawn_location.progress_ratio = randf()
	# The position of said mob is then equal to where it spawned
	mob.position = mob_spawn_location.position
	# Direction variable is based on what the rotation 
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Give the mob a random direction to head towards.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# The speed of movement is also random within a range
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Add the node to the tree
	add_child(mob)


func _on_score_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout() -> void:
	$"Timers/Mob Timer".start()
	$Timers/Score.start()
