extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$"Message Timer".start()

func show_game_over():
	show_message("Game Over")
	await $"Message Timer".timeout
	
	$Message.text = "Dodge the Creeps!"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout
	$"Start Button".show()
	
func update_score(score):
	$"Score Label".text=str(score)
	
func _on_start_button_pressed():
	$"Start Button".hide()
	start_game.emit()
	print("START!")

func _on_message_timer_timeout():
	$Message.hide()
